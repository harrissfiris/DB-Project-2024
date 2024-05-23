import mysql.connector
import random

def generate_episode():
    # Connect to the database
    conn = mysql.connector.connect(
        host='localhost',  # Modify this if your server is on another host
        user='admin',      # Your database username
        password='admin',  # Your database password
        database='masterchef'  # Your database name
    )
    cursor = conn.cursor()

    # Find the year of the last episode
    cursor.execute("SELECT MAX(episode_year) FROM episode")
    last_year = cursor.fetchone()[0]
    
    if last_year is None:
        # If there are no episodes, start from the year 2024
        last_year = 2020
        next_episode_num = 1
    else:
        # Check the number of episodes for the specific year
        cursor.execute("SELECT COUNT(*) FROM episode WHERE episode_year = %s", (last_year,))
        episode_count = cursor.fetchone()[0]

        if episode_count >= 10:
            # If the last year already has 10 episodes, move to the next year
            last_year += 1
            next_episode_num = 1
        else:
            # Calculate the next episode number for the current year
            cursor.execute("SELECT COALESCE(MAX(episode_num), 0) + 1 FROM episode WHERE episode_year = %s", (last_year,))
            next_episode_num = cursor.fetchone()[0]

    # Select random national cuisines
    cursor.execute("SELECT cuisine_id FROM cuisine")
    cuisines = cursor.fetchall()
    
    # Check if there are at least 10 cuisines
    if len(cuisines) < 10:
        raise Exception("Not enough cuisines available.")
    
    selected_cuisines = random.sample(cuisines, 10)

    # Create an entry in the episode table
    cursor.execute("INSERT INTO episode (episode_num, episode_year, picture_id) VALUES (%s, %s, %s)", (next_episode_num, last_year, 20005))
    episode_id = cursor.lastrowid
    conn.commit()

    selected_chefs = []
    assigned_chefs = set()  # To ensure a chef is not selected more than once per episode
    assigned_pairs = set()  # To track unique (competitor_id, recipe_id) pairs

    # Select the last three episodes
    cursor.execute("SELECT episode_id FROM episode ORDER BY episode_num DESC LIMIT 3")
    last_episodes = cursor.fetchall()
    last_episode_ids = [row[0] for row in last_episodes]

    for cuisine in selected_cuisines:
        # Fetch chefs who specialize in the current cuisine and are not competitors in the last three episodes
        placeholders = ', '.join(['%s'] * len(last_episode_ids))
        query = f"""
            SELECT chef_id FROM chef
            WHERE chef_id NOT IN (
                SELECT competitor_id FROM is_assigned
                WHERE episode_id IN ({placeholders})
            ) AND chef_id IN (
                SELECT chef_id FROM specializes
                WHERE cuisine_id = %s
            )
            AND chef_id NOT IN (
                SELECT competitor_id FROM is_assigned
                WHERE episode_id = %s
            )
        """
        params = tuple(last_episode_ids) + (cuisine[0], episode_id)
        cursor.execute(query, params)
        chefs = cursor.fetchall()
        
        if len(chefs) < 1:
            raise Exception(f"Not enough chefs available for cuisine_id {cuisine[0]}. Required: 1, Available: {len(chefs)}")
        
        selected_chef = random.choice([chef for chef in chefs if chef[0] not in assigned_chefs])
        selected_chefs.append(selected_chef)
        assigned_chefs.add(selected_chef[0])

        cursor.execute("""
            SELECT recipe_id FROM recipe
            WHERE cuisine_id = %s
        """, (cuisine[0],))
        recipes = cursor.fetchall()
        
        if len(recipes) < 1:
            raise Exception(f"Not enough recipes available for cuisine_id {cuisine[0]}. Required: 1, Available: {len(recipes)}")

        selected_recipe = random.choice(recipes)

        # Ensure unique assignments for chefs and recipes
        pair_key = (selected_chef[0], selected_recipe[0])
        if pair_key not in assigned_pairs:
            cursor.execute("INSERT INTO is_assigned (competitor_id, episode_id, recipe_id) VALUES (%s, %s, %s)", (selected_chef[0], episode_id, selected_recipe[0]))
            assigned_pairs.add(pair_key)

    # Select random judges
    placeholders = ', '.join(['%s'] * len(last_episode_ids))
    query = f"""
        SELECT chef_id FROM chef
        WHERE chef_id NOT IN (
            SELECT judge_id FROM is_graded
            WHERE episode_id IN ({placeholders})
        ) AND chef_id NOT IN (
            SELECT competitor_id FROM is_assigned
            WHERE episode_id = %s
        )
        AND chef_id NOT IN (
            SELECT competitor_id FROM is_assigned
            WHERE episode_id IN ({placeholders})
        )
    """
    params = tuple(last_episode_ids) + (episode_id,) + tuple(last_episode_ids)
    cursor.execute(query, params)
    judges = cursor.fetchall()
    
    if len(judges) < 3:
        raise Exception(f"Not enough judges available. Required: 3, Available: {len(judges)}")

    selected_judges = random.sample(judges, 3)

    # Ensure there are no overlaps between judges and competitors
    competitor_ids = [chef[0] for chef in selected_chefs]
    selected_judges = [judge for judge in selected_judges if judge[0] not in competitor_ids]

    if len(selected_judges) < 3:
        raise Exception("Not enough unique judges available.")

    # Update the is_graded table with random grades
    graded_pairs = set()  # To track (competitor_id, judge_id, episode_id) combinations
    for judge in selected_judges:
        for chef in selected_chefs:
            grade_key = (chef[0], judge[0], episode_id)
            if grade_key not in graded_pairs:
                random_grade = random.randint(1, 5)
                cursor.execute("INSERT INTO is_graded (competitor_id, judge_id, episode_id, grade) VALUES (%s, %s, %s, %s)", (chef[0], judge[0], episode_id, random_grade))
                graded_pairs.add(grade_key)
    
    # Debugging output to trace the assignment
    print(f"Episode {episode_id}:")
    print(f"  Competitors: {[chef[0] for chef in selected_chefs]}")
    print(f"  Judges: {[judge[0] for judge in selected_judges]}")
    print(f"  Graded pairs: {len(graded_pairs)}")

    conn.commit()

    # Μετά τον ορισμό όλων των διαγωνιζομένων και των βαθμολογήσεων, καλείται η calculate_winner
    cursor.execute("CALL calculate_winner(%s)", (episode_id,))

    conn.commit()
    cursor.close()
    conn.close()

    return episode_id

# Use the function
for _ in range(5):
    new_episode_id = generate_episode()
    print(f"New episode created with ID: {new_episode_id}")

# Additional check to count the rows in is_graded
conn = mysql.connector.connect(
    host='localhost',
    user='admin',
    password='admin',
    database='masterchef'
)
cursor = conn.cursor()
cursor.execute("SELECT COUNT(*) FROM is_graded")
row_count = cursor.fetchone()[0]
print(f"Total rows in is_graded: {row_count}")

conn.close()
