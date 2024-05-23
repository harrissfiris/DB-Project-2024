-- -----------------------------------------------------
-- procedure calculate_winner
-- -----------------------------------------------------

DELIMITER $$
USE `masterchef`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `calculate_winner`(IN in_episode_id INT)
BEGIN
    DECLARE max_avg_grade DECIMAL(5, 2);
    DECLARE winner_count INT;
    DECLARE candidate_id INT;
    DECLARE candidate_rank VARCHAR(20);
    DECLARE done INT DEFAULT 0;
    DECLARE winner_id INT;

    -- Cursor to iterate over potential winners
    DECLARE winner_cursor CURSOR FOR
        SELECT c.competitor_id, ch.chef_rank
        FROM comp_avg_scores c
        JOIN chef ch ON c.competitor_id = ch.chef_id
        WHERE c.episode_id = in_episode_id
        ORDER BY c.avg_grade DESC, 
                 CASE ch.chef_rank
                     WHEN 'Chef' THEN 5
                     WHEN 'Sous Chef' THEN 4
                     WHEN 'Cook A' THEN 3
                     WHEN 'Cook B' THEN 2
                     WHEN 'Cook C' THEN 1
                     ELSE 0
                 END DESC, RAND()
        LIMIT 1;
    
    -- Handler for cursor end
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Get the maximum average grade for the episode
    SELECT MAX(avg_grade) INTO max_avg_grade
    FROM comp_avg_scores
    WHERE episode_id = in_episode_id;

    -- Get the count of competitors with the max average grade
    SELECT COUNT(*) INTO winner_count
    FROM comp_avg_scores
    WHERE episode_id = in_episode_id
    AND avg_grade = max_avg_grade;

    IF winner_count = 1 THEN
        -- If there is only one winner with the max average grade
        SELECT competitor_id INTO winner_id
        FROM comp_avg_scores
        WHERE episode_id = in_episode_id
        AND avg_grade = max_avg_grade
        LIMIT 1;
    ELSE
        -- If there are multiple winners with the same average grade, use the cursor to determine the winner
        OPEN winner_cursor;

        read_loop: LOOP
            FETCH winner_cursor INTO candidate_id, candidate_rank;
            IF done THEN
                LEAVE read_loop;
            END IF;
            SET winner_id = candidate_id;
        END LOOP;

        CLOSE winner_cursor;
    END IF;

    -- Update the episode table with the winner_id
    UPDATE episode
    SET winner_id = winner_id
    WHERE episode_id = in_episode_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure calory_count
-- -----------------------------------------------------

DELIMITER $$
USE `masterchef`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `calory_count`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE rec_id INT;
    DECLARE portions INT;
    DECLARE total_calories FLOAT;

    -- Cursor for selecting all recipes
    DECLARE recipe_cursor CURSOR FOR
        SELECT recipe_id, portions_made
        FROM recipe;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Open the cursor
    OPEN recipe_cursor;
    
    read_loop: LOOP
        FETCH recipe_cursor INTO rec_id, portions;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Calculate total calories for the recipe
        SET total_calories = (
            SELECT SUM(
                CASE
                    WHEN c.unit_of_measure = 'cup' THEN COALESCE(c.number, 0) * 200 * i.cals_per_100 / 100.0
                    ELSE COALESCE(c.number, 0) * i.cals_per_100 / 100.0
                END
            ) 
            FROM contains c
            JOIN ingredient i ON c.ingredient_id = i.ingredient_id
            WHERE c.recipe_id = rec_id
        );
        
        -- Calculate calories per portion
        SET total_calories = COALESCE(total_calories, 0) / COALESCE(portions, 1);
        
        -- Insert or update the recipe_calories table
        INSERT INTO recipe_calories (recipe_id, calorie_number)
        VALUES (rec_id, total_calories)
        ON DUPLICATE KEY UPDATE calorie_number = total_calories;
    END LOOP;
    
    -- Close the cursor
    CLOSE recipe_cursor;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure generate_recipe_them_units
-- -----------------------------------------------------

DELIMITER $$
USE `masterchef`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generate_recipe_them_units`()
BEGIN
    DECLARE done_recipes INT DEFAULT FALSE;
    DECLARE done_units INT DEFAULT FALSE;
    DECLARE rec_id INT;
    DECLARE them_id INT;
    DECLARE num_units INT;
    DECLARE counter INT;

    -- Cursor for selecting all recipes
    DECLARE recipe_cursor CURSOR FOR
        SELECT recipe_id FROM recipe;

    -- Cursor for selecting thematic units
    DECLARE them_unit_cursor CURSOR FOR
        SELECT them_unit_id FROM them_unit ORDER BY RAND();

    -- Handlers for the cursors
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_recipes = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done_units = TRUE;

    -- Open the cursor for recipes
    OPEN recipe_cursor;

    read_loop: LOOP
        FETCH recipe_cursor INTO rec_id;
        
        IF done_recipes THEN
            LEAVE read_loop;
        END IF;

        -- Choose a random number of thematic units (e.g., from 1 to 5)
        SET num_units = FLOOR(1 + RAND() * 5);
        SET counter = 0;

        -- Open the cursor for thematic units
        OPEN them_unit_cursor;

        unit_loop: LOOP
            FETCH them_unit_cursor INTO them_id;

            IF done_units THEN
                SET done_units = FALSE;
                LEAVE unit_loop;
            END IF;

            -- Insert the thematic unit for the recipe
            INSERT INTO recipe_them_unit (recipe_id, them_unit_id)
            VALUES (rec_id, them_id);

            SET counter = counter + 1;
            
            IF counter >= num_units THEN
                LEAVE unit_loop;
            END IF;
        END LOOP;

        -- Close the cursor for thematic units
        CLOSE them_unit_cursor;
    END LOOP;

    -- Close the cursor for recipes
    CLOSE recipe_cursor;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_assigned_recipe
-- -----------------------------------------------------

DELIMITER $$
USE `masterchef`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_assigned_recipe`(
    IN p_username VARCHAR(255),
    IN p_current_password VARCHAR(255),
    IN p_recipe_id INT,
    IN p_recipe_type VARCHAR(100),
    IN p_cuisine_id INT,
    IN p_difficulty INT,
    IN p_recipe_name VARCHAR(100),
    IN p_description TEXT,
    IN p_tip_1 TEXT,
    IN p_tip_2 TEXT,
    IN p_tip_3 TEXT,
    IN p_cooking_time_mins INT,
    IN p_preparation_time_mins INT,
    IN p_steps TEXT,
    IN p_portions_made INT,
    IN p_basic_ingr_id INT,
    IN p_fat_g INT,
    IN p_protein_g INT,
    IN p_carbs_g INT
)
BEGIN
    DECLARE v_chef_id INT;
    DECLARE v_stored_password VARCHAR(255);
    DECLARE v_cuisine_exists INT;
    DECLARE v_basic_ingr_exists INT;

    -- Βρίσκουμε τον chef_id και τον κωδικό από τη βάση δεδομένων για το username που συνδέθηκε
    SELECT chef_id, password INTO v_chef_id, v_stored_password
    FROM chef
    WHERE username = p_username;

    -- Ελέγχουμε αν ο τρέχων κωδικός πρόσβασης είναι σωστός
    IF v_stored_password = p_current_password THEN
        -- Ελέγχουμε αν η συνταγή είναι ανατεθειμένη στον συγκεκριμένο μάγειρα
        IF EXISTS (SELECT 1 FROM is_assigned WHERE recipe_id = p_recipe_id AND competitor_id = v_chef_id) THEN
            -- Ελέγχουμε αν το cuisine_id υπάρχει στον πίνακα cuisine
            SELECT COUNT(*) INTO v_cuisine_exists
            FROM cuisine
            WHERE cuisine_id = p_cuisine_id;
            
            -- Ελέγχουμε αν το basic_ingr_id υπάρχει στον πίνακα ingredient
            SELECT COUNT(*) INTO v_basic_ingr_exists
            FROM ingredient
            WHERE ingredient_id = p_basic_ingr_id;

            IF v_cuisine_exists > 0 AND v_basic_ingr_exists > 0 THEN
                -- Ενημέρωση της συνταγής
                UPDATE recipe
                SET recipe_type = p_recipe_type,
                    cuisine_id = p_cuisine_id,
                    difficulty = p_difficulty,
                    recipe_name = p_recipe_name,
                    description = p_description,
                    tip_1 = p_tip_1,
                    tip_2 = p_tip_2,
                    tip_3 = p_tip_3,
                    cooking_time_mins = p_cooking_time_mins,
                    preparation_time_mins = p_preparation_time_mins,
                    steps = p_steps,
                    portions_made = p_portions_made,
                    basic_ingr_id = p_basic_ingr_id,
                    fat_g = p_fat_g,
                    protein_g = p_protein_g,
                    carbs_g = p_carbs_g
                WHERE recipe_id = p_recipe_id;
            ELSE
                IF v_cuisine_exists = 0 THEN
                    SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Invalid cuisine_id';
                ELSE
                    SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Invalid basic_ingr_id';
                END IF;
            END IF;
        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'You do not have permission to update this recipe';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid password';
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_info
-- -----------------------------------------------------

DELIMITER $$
USE `masterchef`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_info`(
    IN p_username VARCHAR(255),
    IN p_current_password VARCHAR(255),
    IN p_first_name VARCHAR(255),
    IN p_last_name VARCHAR(255),
    IN p_phone_number VARCHAR(20),
    IN p_birth_date DATE,
    IN p_age INT,
    IN p_years_of_exp INT,
    IN p_chef_rank VARCHAR(255)
)
BEGIN
    DECLARE v_chef_id INT;
    DECLARE v_stored_password VARCHAR(255);

    -- Βρίσκουμε τον κωδικό από τη βάση δεδομένων για το username που συνδέθηκε
    SELECT chef_id, password INTO v_chef_id, v_stored_password
    FROM chef
    WHERE username = p_username;

    -- Ελέγχουμε αν ο τρέχων κωδικός πρόσβασης είναι σωστός
    IF v_stored_password = p_current_password THEN
        -- Ενημέρωση προσωπικών στοιχείων
        UPDATE chef
        SET first_name = p_first_name,
            last_name = p_last_name,
            phone_number = p_phone_number,
            birth_date = p_birth_date,
            age = p_age,
            years_of_exp = p_years_of_exp,
            chef_rank = p_chef_rank
        WHERE chef_id = v_chef_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid password';
    END IF;
END$$

DELIMITER ;

