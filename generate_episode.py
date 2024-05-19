import mysql.connector
import random

def generate_episode():
    # Σύνδεση στη βάση δεδομένων
    conn = mysql.connector.connect(
        host='localhost',  # Τροποποιήστε το αν ο server σας είναι σε άλλο host
        user='root',       # Το όνομα χρήστη της βάσης δεδομένων σας
        password='password123',  # Ο κωδικός πρόσβασης της βάσης δεδομένων σας
        database='cooking_competition'  # Το όνομα της βάσης δεδομένων σας
    )
    cursor = conn.cursor()

    # Εύρεση του έτους του τελευταίου επεισοδίου
    cursor.execute("SELECT MAX(year) FROM episode")
    last_year = cursor.fetchone()[0]
    
    if last_year is None:
        # Αν δεν υπάρχουν επεισόδια, ξεκινάμε από το έτος 2024
        last_year = 2020
        next_episode_num = 1
    else:
        # Έλεγχος του αριθμού επεισοδίων για το συγκεκριμένο έτος
        cursor.execute("SELECT COUNT(*) FROM episode WHERE year = %s", (last_year,))
        episode_count = cursor.fetchone()[0]

        if episode_count >= 10:
            # Αν το τελευταίο έτος έχει ήδη 10 επεισόδια, προχωράμε στο επόμενο έτος
            last_year += 1
            next_episode_num = 1
        else:
            # Υπολογισμός του επόμενου episode_num για το τρέχον έτος
            cursor.execute("SELECT COALESCE(MAX(episode_num), 0) + 1 FROM episode WHERE year = %s", (last_year,))
            next_episode_num = cursor.fetchone()[0]

    # Επιλογή τυχαίων εθνικών κουζινών
    cursor.execute("SELECT cuisine_id FROM cuisine")
    cuisines = cursor.fetchall()
    
    # Ελέγχουμε αν υπάρχουν τουλάχιστον 10 κουζίνες
    if len(cuisines) < 10:
        raise Exception("Not enough cuisines available.")
    
    selected_cuisines = random.sample(cuisines, 10)

    # Δημιουργία καταχώρησης στο πίνακα episode
    cursor.execute("INSERT INTO episode (episode_num, year, picture_id) VALUES (%s, %s, %s)", (next_episode_num, last_year, 20005))
    episode_id = cursor.lastrowid
    conn.commit()

    selected_chefs = []

    # Επιλογή τυχαίων μαγείρων και συνταγών από κάθε κουζίνα
    for cuisine in selected_cuisines:
        cursor.execute("""
            SELECT chef_id FROM chef
            WHERE chef_id NOT IN (
                SELECT competitor_id FROM is_assigned
                WHERE episode_id IN (
                    SELECT episode_id FROM episode
                    ORDER BY episode_num DESC
                    LIMIT 3
                )
            ) AND chef_id IN (
                SELECT chef_id FROM specializes
                WHERE cuisine_id = %s
            )
        """, (cuisine[0],))
        chefs = cursor.fetchall()
        selected_chefs.extend(random.sample(chefs, 10))

        cursor.execute("""
            SELECT recipe_id FROM recipe
            WHERE cuisine_id = %s
        """, (cuisine[0],))
        recipes = cursor.fetchall()
        selected_recipes = random.sample(recipes, 10)

        # Ανάθεση συνταγών σε μάγειρες
        for chef, recipe in zip(selected_chefs[-10:], selected_recipes):
            cursor.execute("INSERT INTO is_assigned (competitor_id, episode_id, recipe_id) VALUES (%s, %s, %s)", (chef[0], episode_id, recipe[0]))

    # Επιλογή τυχαίων κριτών
    cursor.execute("""
        SELECT chef_id FROM chef
        WHERE chef_id NOT IN (
            SELECT judge_id FROM is_graded
            WHERE episode_id IN (
                SELECT episode_id FROM episode
                ORDER BY episode_num DESC
                LIMIT 3
            )
        ) AND chef_id NOT IN (
            SELECT competitor_id FROM is_assigned
            WHERE episode_id = %s
        )
    """, (episode_id,))
    judges = cursor.fetchall()
    selected_judges = random.sample(judges, 3)

    # Ενημέρωση του πίνακα is_graded με τυχαία βαθμολογία
    for judge in selected_judges:
        for chef in selected_chefs:
            random_grade = random.randint(1, 5)
            cursor.execute("INSERT INTO is_graded (competitor_id, judge_id, episode_id, grade) VALUES (%s, %s, %s, %s)", (chef[0], judge[0], episode_id, random_grade))

    conn.commit()
    cursor.close()
    conn.close()

    return episode_id

# Χρήση της συνάρτησης
new_episode_id = generate_episode()
print(f"New episode created with ID: {new_episode_id}")

