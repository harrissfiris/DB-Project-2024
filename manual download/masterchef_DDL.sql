SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema masterchef
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `masterchef` ;

-- -----------------------------------------------------
-- Schema masterchef
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `masterchef` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `masterchef` ;

-- -----------------------------------------------------
-- Table `masterchef`.`picture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`picture` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`picture` (
  `picture_id` INT NOT NULL AUTO_INCREMENT,
  `description` TEXT NOT NULL,
  `pic` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`picture_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 20001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `picture_unique` ON `masterchef`.`picture` (`picture_id` ASC);


-- -----------------------------------------------------
-- Table `masterchef`.`chef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`chef` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`chef` (
  `chef_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `phone_number` TEXT NOT NULL,
  `birth_date` DATE NOT NULL,
  `age` INT NOT NULL,
  `years_of_exp` INT NOT NULL,
  `chef_rank` ENUM('Cook C', 'Cook B', 'Cook A', 'Sous Chef', 'Chef') NULL DEFAULT NULL,
  `picture_id` INT NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`chef_id`),
  CONSTRAINT `chef_picture_FK`
    FOREIGN KEY (`picture_id`)
    REFERENCES `masterchef`.`picture` (`picture_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `chef_unique` ON `masterchef`.`chef` (`chef_id` ASC) VISIBLE;

CREATE INDEX `chef_chef_id_IDX` USING BTREE ON `masterchef`.`chef` (`chef_id`, `first_name`, `last_name`) VISIBLE;

CREATE INDEX `chef_picture_FK` ON `masterchef`.`chef` (`picture_id` ASC) VISIBLE;

CREATE INDEX `chef_chef_rank_IDX` USING BTREE ON `masterchef`.`chef` (`chef_rank`) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`food_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`food_group` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`food_group` (
  `food_group_id` INT NOT NULL AUTO_INCREMENT,
  `food_group_name` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `description` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `diet_type` VARCHAR(100) NOT NULL,
  `picture_id` INT NOT NULL,
  PRIMARY KEY (`food_group_id`),
  CONSTRAINT `food_group_picture_FK`
    FOREIGN KEY (`picture_id`)
    REFERENCES `masterchef`.`picture` (`picture_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 12001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `food_group_unique` ON `masterchef`.`food_group` (`food_group_id` ASC) VISIBLE;

CREATE INDEX `food_group_picture_FK` ON `masterchef`.`food_group` (`picture_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`ingredient` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`ingredient` (
  `ingredient_id` INT NOT NULL AUTO_INCREMENT,
  `ingredient_name` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `food_group_id` INT NOT NULL,
  `cals_per_100` INT NOT NULL,
  `picture_id` INT NOT NULL,
  PRIMARY KEY (`ingredient_id`),
  CONSTRAINT `ingredient_food_group_FK`
    FOREIGN KEY (`food_group_id`)
    REFERENCES `masterchef`.`food_group` (`food_group_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `ingredient_picture_FK`
    FOREIGN KEY (`picture_id`)
    REFERENCES `masterchef`.`picture` (`picture_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `ingredient_unique` ON `masterchef`.`ingredient` (`ingredient_id` ASC) VISIBLE;

CREATE INDEX `ingredient_food_group_FK` ON `masterchef`.`ingredient` (`food_group_id` ASC) VISIBLE;

CREATE INDEX `ingredient_ingredient_id_IDX` USING BTREE ON `masterchef`.`ingredient` (`ingredient_id`, `cals_per_100`) VISIBLE;

CREATE INDEX `ingredient_picture_FK` ON `masterchef`.`ingredient` (`picture_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`cuisine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`cuisine` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`cuisine` (
  `cuisine_id` INT NOT NULL AUTO_INCREMENT,
  `cuisine_name` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `picture_id` INT NOT NULL,
  PRIMARY KEY (`cuisine_id`),
  CONSTRAINT `cuisine_picture_FK`
    FOREIGN KEY (`picture_id`)
    REFERENCES `masterchef`.`picture` (`picture_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 8001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `cuisine_unique` ON `masterchef`.`cuisine` (`cuisine_id` ASC) VISIBLE;

CREATE INDEX `cuisine_picture_FK` ON `masterchef`.`cuisine` (`picture_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`recipe` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`recipe` (
  `recipe_id` INT NOT NULL AUTO_INCREMENT,
  `recipe_type` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `cuisine_id` INT NOT NULL,
  `difficulty` INT NOT NULL,
  `recipe_name` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `description` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `tip_1` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NULL DEFAULT NULL,
  `tip_2` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NULL DEFAULT NULL,
  `tip_3` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NULL DEFAULT NULL,
  `cooking_time_mins` INT NOT NULL,
  `preparation_time_mins` INT NOT NULL,
  `steps` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `portions_made` INT NOT NULL,
  `basic_ingr_id` INT NOT NULL,
  `fat_g` INT NULL DEFAULT NULL,
  `protein_g` INT NULL DEFAULT NULL,
  `carbs_g` INT NULL DEFAULT NULL,
  `picture_id` INT NOT NULL,
  PRIMARY KEY (`recipe_id`),
  CONSTRAINT `recipe_cuisine_FK`
    FOREIGN KEY (`cuisine_id`)
    REFERENCES `masterchef`.`cuisine` (`cuisine_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `recipe_ingredient_FK`
    FOREIGN KEY (`basic_ingr_id`)
    REFERENCES `masterchef`.`ingredient` (`ingredient_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `recipe_picture_FK`
    FOREIGN KEY (`picture_id`)
    REFERENCES `masterchef`.`picture` (`picture_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `recipe_id_unique` ON `masterchef`.`recipe` (`recipe_id` ASC) VISIBLE;

CREATE INDEX `recipe_cuisine_FK` ON `masterchef`.`recipe` (`cuisine_id` ASC) VISIBLE;

CREATE INDEX `recipe_ingredient_FK` ON `masterchef`.`recipe` (`basic_ingr_id` ASC) VISIBLE;

CREATE INDEX `recipe_recipe_id_IDX` USING BTREE ON `masterchef`.`recipe` (`recipe_id`, `cuisine_id`) VISIBLE;

CREATE INDEX `recipe_picture_FK` ON `masterchef`.`recipe` (`picture_id` ASC) VISIBLE;

CREATE INDEX `recipe_carbs_g_IDX` USING BTREE ON `masterchef`.`recipe` (`carbs_g`) VISIBLE;

CREATE INDEX `recipe_difficulty_IDX` USING BTREE ON `masterchef`.`recipe` (`difficulty`) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`contains`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`contains` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`contains` (
  `recipe_id` INT NOT NULL,
  `ingredient_id` INT NOT NULL,
  `unit_of_measure` VARCHAR(100) NULL DEFAULT NULL,
  `number` INT NULL DEFAULT NULL,
  PRIMARY KEY (`recipe_id`, `ingredient_id`),
  CONSTRAINT `contains_ingredient_FK`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `masterchef`.`ingredient` (`ingredient_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `contains_recipe_FK`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `masterchef`.`recipe` (`recipe_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `contains_ingredient_FK` ON `masterchef`.`contains` (`ingredient_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`episode`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`episode` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`episode` (
  `episode_id` INT NOT NULL AUTO_INCREMENT,
  `episode_num` INT NOT NULL,
  `episode_year` YEAR NOT NULL,
  `winner_id` INT NULL DEFAULT NULL,
  `picture_id` INT NOT NULL,
  PRIMARY KEY (`episode_id`),
  CONSTRAINT `episode_chef_FK`
    FOREIGN KEY (`winner_id`)
    REFERENCES `masterchef`.`chef` (`chef_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `episode_picture_FK`
    FOREIGN KEY (`picture_id`)
    REFERENCES `masterchef`.`picture` (`picture_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `episode_unique` ON `masterchef`.`episode` (`episode_id` ASC) VISIBLE;

CREATE INDEX `episode_episode_id_IDX` USING BTREE ON `masterchef`.`episode` (`episode_id`, `episode_year`) VISIBLE;

CREATE INDEX `episode_chef_FK` ON `masterchef`.`episode` (`winner_id` ASC) VISIBLE;

CREATE INDEX `episode_picture_FK` ON `masterchef`.`episode` (`picture_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`equipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`equipment` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`equipment` (
  `equipment_id` INT NOT NULL AUTO_INCREMENT,
  `equipment_name` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `instructions` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `picture_id` INT NOT NULL,
  PRIMARY KEY (`equipment_id`),
  CONSTRAINT `equipment_picture_FK`
    FOREIGN KEY (`picture_id`)
    REFERENCES `masterchef`.`picture` (`picture_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `equipment_unique` ON `masterchef`.`equipment` (`equipment_id` ASC) VISIBLE;

CREATE INDEX `equipment_picture_FK` ON `masterchef`.`equipment` (`picture_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`is_assigned`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`is_assigned` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`is_assigned` (
  `competitor_id` INT NOT NULL,
  `episode_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  PRIMARY KEY (`competitor_id`, `episode_id`, `recipe_id`),
  CONSTRAINT `is_assigned_chef_FK`
    FOREIGN KEY (`competitor_id`)
    REFERENCES `masterchef`.`chef` (`chef_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `is_assigned_episode_FK`
    FOREIGN KEY (`episode_id`)
    REFERENCES `masterchef`.`episode` (`episode_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `is_assigned_recipe_FK`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `masterchef`.`recipe` (`recipe_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `is_assigned_unique` ON `masterchef`.`is_assigned` (`competitor_id` ASC, `episode_id` ASC) VISIBLE;

CREATE INDEX `is_assigned_episode_FK` ON `masterchef`.`is_assigned` (`episode_id` ASC) VISIBLE;

CREATE INDEX `is_assigned_recipe_FK` ON `masterchef`.`is_assigned` (`recipe_id` ASC) VISIBLE;

CREATE INDEX `is_assigned_competitor_recipe_IDX` USING BTREE ON `masterchef`.`is_assigned` (`competitor_id`, `recipe_id`) VISIBLE;

CREATE INDEX `is_assigned_recipe_id_IDX` USING BTREE ON `masterchef`.`is_assigned` (`recipe_id`, `episode_id`) VISIBLE;

CREATE INDEX `is_assigned_competitor_id_IDX` USING BTREE ON `masterchef`.`is_assigned` (`competitor_id`) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`is_graded`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`is_graded` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`is_graded` (
  `competitor_id` INT NOT NULL,
  `judge_id` INT NOT NULL,
  `episode_id` INT NOT NULL,
  `grade` INT NOT NULL,
  PRIMARY KEY (`competitor_id`, `judge_id`, `episode_id`),
  CONSTRAINT `is_graded_chef_FK`
    FOREIGN KEY (`competitor_id`)
    REFERENCES `masterchef`.`chef` (`chef_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `is_graded_chef_FK_1`
    FOREIGN KEY (`judge_id`)
    REFERENCES `masterchef`.`chef` (`chef_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `is_graded_episode_FK`
    FOREIGN KEY (`episode_id`)
    REFERENCES `masterchef`.`episode` (`episode_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `is_graded_episode_FK` ON `masterchef`.`is_graded` (`episode_id` ASC) VISIBLE;

CREATE INDEX `is_graded_chef_FK_1` ON `masterchef`.`is_graded` (`judge_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`label`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`label` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`label` (
  `label_id` INT NOT NULL AUTO_INCREMENT,
  `label_name` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `picture_id` INT NOT NULL,
  PRIMARY KEY (`label_id`),
  CONSTRAINT `label_picture_FK`
    FOREIGN KEY (`picture_id`)
    REFERENCES `masterchef`.`picture` (`picture_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `label_unique` ON `masterchef`.`label` (`label_id` ASC) VISIBLE;

CREATE INDEX `label_picture_FK` ON `masterchef`.`label` (`picture_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`meal_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`meal_type` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`meal_type` (
  `meal_type_id` INT NOT NULL AUTO_INCREMENT,
  `meal_type_name` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `picture_id` INT NOT NULL,
  PRIMARY KEY (`meal_type_id`),
  CONSTRAINT `meal_type_picture_FK`
    FOREIGN KEY (`picture_id`)
    REFERENCES `masterchef`.`picture` (`picture_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 10001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `meal_type_unique` ON `masterchef`.`meal_type` (`meal_type_id` ASC) VISIBLE;

CREATE INDEX `meal_type_picture_FK` ON `masterchef`.`meal_type` (`picture_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`recipe_calories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`recipe_calories` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`recipe_calories` (
  `recipe_id` INT NOT NULL,
  `calorie_number` INT NOT NULL,
  PRIMARY KEY (`recipe_id`),
  CONSTRAINT `recipe_calories_recipe_FK`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `masterchef`.`recipe` (`recipe_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masterchef`.`recipe_equipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`recipe_equipment` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`recipe_equipment` (
  `recipe_id` INT NOT NULL,
  `equipment_id` INT NOT NULL,
  PRIMARY KEY (`recipe_id`, `equipment_id`),
  CONSTRAINT `recipe_equipment_equipment_FK`
    FOREIGN KEY (`equipment_id`)
    REFERENCES `masterchef`.`equipment` (`equipment_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `recipe_equipment_recipe_FK`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `masterchef`.`recipe` (`recipe_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `recipe_equipment_equipment_FK` ON `masterchef`.`recipe_equipment` (`equipment_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`recipe_label`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`recipe_label` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`recipe_label` (
  `recipe_id` INT NOT NULL,
  `label_id` INT NOT NULL,
  PRIMARY KEY (`recipe_id`, `label_id`),
  CONSTRAINT `recipe_label_label_FK`
    FOREIGN KEY (`label_id`)
    REFERENCES `masterchef`.`label` (`label_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `recipe_label_recipe_FK`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `masterchef`.`recipe` (`recipe_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `recipe_label_label_FK` ON `masterchef`.`recipe_label` (`label_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`recipe_meal_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`recipe_meal_type` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`recipe_meal_type` (
  `recipe_id` INT NOT NULL,
  `meal_type_id` INT NOT NULL,
  PRIMARY KEY (`recipe_id`, `meal_type_id`),
  CONSTRAINT `recipe_meal_type_meal_type_FK`
    FOREIGN KEY (`meal_type_id`)
    REFERENCES `masterchef`.`meal_type` (`meal_type_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `recipe_meal_type_recipe_FK`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `masterchef`.`recipe` (`recipe_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `recipe_meal_type_meal_type_FK` ON `masterchef`.`recipe_meal_type` (`meal_type_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`them_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`them_unit` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`them_unit` (
  `them_unit_id` INT NOT NULL AUTO_INCREMENT,
  `them_unit_name` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `description` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `picture_id` INT NOT NULL,
  PRIMARY KEY (`them_unit_id`),
  CONSTRAINT `them_unit_picture_FK`
    FOREIGN KEY (`picture_id`)
    REFERENCES `masterchef`.`picture` (`picture_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 13001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `them_unit_unique` ON `masterchef`.`them_unit` (`them_unit_id` ASC) VISIBLE;

CREATE INDEX `them_unit_picture_FK` ON `masterchef`.`them_unit` (`picture_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`recipe_them_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`recipe_them_unit` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`recipe_them_unit` (
  `recipe_id` INT NOT NULL,
  `them_unit_id` INT NOT NULL,
  PRIMARY KEY (`recipe_id`, `them_unit_id`),
  CONSTRAINT `recipe_them_unit_recipe_FK`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `masterchef`.`recipe` (`recipe_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `recipe_them_unit_them_unit_FK`
    FOREIGN KEY (`them_unit_id`)
    REFERENCES `masterchef`.`them_unit` (`them_unit_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `recipe_them_unit_them_unit_FK` ON `masterchef`.`recipe_them_unit` (`them_unit_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `masterchef`.`specializes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`specializes` ;

CREATE TABLE IF NOT EXISTS `masterchef`.`specializes` (
  `chef_id` INT NOT NULL,
  `cuisine_id` INT NOT NULL,
  PRIMARY KEY (`chef_id`, `cuisine_id`),
  CONSTRAINT `specializes_chef_FK`
    FOREIGN KEY (`chef_id`)
    REFERENCES `masterchef`.`chef` (`chef_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `specializes_cuisine_FK`
    FOREIGN KEY (`cuisine_id`)
    REFERENCES `masterchef`.`cuisine` (`cuisine_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `specializes_cuisine_FK` ON `masterchef`.`specializes` (`cuisine_id` ASC) VISIBLE;

USE `masterchef` ;

-- -----------------------------------------------------
-- Placeholder table for view `masterchef`.`chef_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masterchef`.`chef_info` (`chef_id` INT, `first_name` INT, `last_name` INT, `phone_number` INT, `birth_date` INT, `age` INT, `years_of_exp` INT, `chef_rank` INT);

-- -----------------------------------------------------
-- Placeholder table for view `masterchef`.`comp_avg_scores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masterchef`.`comp_avg_scores` (`competitor_id` INT, `episode_id` INT, `avg_grade` INT, `recipe_id` INT, `cuisine_id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `masterchef`.`comp_cuisine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masterchef`.`comp_cuisine` (`competitor_id` INT, `episode_id` INT, `cuisine_id` INT);

-- -----------------------------------------------------
-- procedure calculate_winner
-- -----------------------------------------------------

USE `masterchef`;
DROP procedure IF EXISTS `masterchef`.`calculate_winner`;

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

USE `masterchef`;
DROP procedure IF EXISTS `masterchef`.`calory_count`;

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

USE `masterchef`;
DROP procedure IF EXISTS `masterchef`.`generate_recipe_them_units`;

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

USE `masterchef`;
DROP procedure IF EXISTS `masterchef`.`update_assigned_recipe`;

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

USE `masterchef`;
DROP procedure IF EXISTS `masterchef`.`update_info`;

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

-- -----------------------------------------------------
-- View `masterchef`.`chef_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`chef_info`;
DROP VIEW IF EXISTS `masterchef`.`chef_info` ;
USE `masterchef`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `masterchef`.`chef_info` AS select `masterchef`.`chef`.`chef_id` AS `chef_id`,`masterchef`.`chef`.`first_name` AS `first_name`,`masterchef`.`chef`.`last_name` AS `last_name`,`masterchef`.`chef`.`phone_number` AS `phone_number`,`masterchef`.`chef`.`birth_date` AS `birth_date`,`masterchef`.`chef`.`age` AS `age`,`masterchef`.`chef`.`years_of_exp` AS `years_of_exp`,`masterchef`.`chef`.`chef_rank` AS `chef_rank` from `masterchef`.`chef`;

-- -----------------------------------------------------
-- View `masterchef`.`comp_avg_scores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`comp_avg_scores`;
DROP VIEW IF EXISTS `masterchef`.`comp_avg_scores` ;
USE `masterchef`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `masterchef`.`comp_avg_scores` AS select `ig`.`competitor_id` AS `competitor_id`,`ig`.`episode_id` AS `episode_id`,avg(`ig`.`grade`) AS `avg_grade`,`ia`.`recipe_id` AS `recipe_id`,`masterchef`.`recipe`.`cuisine_id` AS `cuisine_id` from ((`masterchef`.`is_graded` `ig` join `masterchef`.`is_assigned` `ia` on(((`ig`.`competitor_id` = `ia`.`competitor_id`) and (`ig`.`episode_id` = `ia`.`episode_id`)))) join `masterchef`.`recipe` on((`ia`.`recipe_id` = `masterchef`.`recipe`.`recipe_id`))) group by `ig`.`competitor_id`,`ig`.`episode_id`;

-- -----------------------------------------------------
-- View `masterchef`.`comp_cuisine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `masterchef`.`comp_cuisine`;
DROP VIEW IF EXISTS `masterchef`.`comp_cuisine` ;
USE `masterchef`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `masterchef`.`comp_cuisine` AS select `ia`.`competitor_id` AS `competitor_id`,`ia`.`episode_id` AS `episode_id`,`r`.`cuisine_id` AS `cuisine_id` from (`masterchef`.`is_assigned` `ia` join `masterchef`.`recipe` `r` on((`r`.`recipe_id` = `ia`.`recipe_id`)));
USE `masterchef`;

DELIMITER $$

USE `masterchef`$$
DROP TRIGGER IF EXISTS `masterchef`.`after_insert_recipe` $$
USE `masterchef`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `masterchef`.`after_insert_recipe`
AFTER INSERT ON `masterchef`.`recipe`
FOR EACH ROW
BEGIN 
    CALL calory_count; 
END$$


USE `masterchef`$$
DROP TRIGGER IF EXISTS `masterchef`.`after_update_recipe` $$
USE `masterchef`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `masterchef`.`after_update_recipe`
AFTER UPDATE ON `masterchef`.`recipe`
FOR EACH ROW
BEGIN 
    CALL calory_count(); 
END$$


USE `masterchef`$$
DROP TRIGGER IF EXISTS `masterchef`.`after_insert_contains` $$
USE `masterchef`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `masterchef`.`after_insert_contains`
AFTER INSERT ON `masterchef`.`contains`
FOR EACH ROW
BEGIN 
    CALL calory_count(); 
END$$


USE `masterchef`$$
DROP TRIGGER IF EXISTS `masterchef`.`after_update_contains` $$
USE `masterchef`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `masterchef`.`after_update_contains`
AFTER UPDATE ON `masterchef`.`contains`
FOR EACH ROW
BEGIN 
    CALL calory_count(); 
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
