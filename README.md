# Cooking Competition Database (DB-Project-2024)

A comprehensive relational database system for managing a cooking competition. This project was developed as part of a university assignment and models complex relationships between chefs, recipes, ingredients, equipment, cuisines, and competition episodes.

## Project Structure

- `masterchef_DDL.sql` – Contains the SQL statements for creating all tables, constraints, views, indexes, triggers, and stored procedures.
- `masterchef_DML.sql` – Populates the database with sample data.
- `create_users.sql` – Creates specific MySQL users for accessing the database.
- Python Scripts:
  - `episode_generator.py`: Generates mock competition episodes.
  - `DB_PIC_INSERT.py`: Inserts images into the database.
  - `show_picture.py`: Retrieves and displays images from the database.

## Main Features

- **Recipes** with difficulty levels, national cuisines, labels, thematic units, and calories.
- **Chefs** that can specialize in multiple cuisines and serve as judges or participants.
- **Episodes** featuring multiple participants and judges, where scores are recorded and winners determined.
- **Detailed relationships** via junction tables (e.g., `contains`, `recipe_equipment`, `is_graded`, etc.).
- **Indexes** and **forced query plans** to optimize performance for specific analytical queries.


## Installation Instructions

### 1. Database Setup

1. Install MySQL: [https://www.mysql.com/](https://www.mysql.com/)
2. (Optional) Install MySQL Workbench.
3. Clone the repository:

```bash
git clone https://github.com/harrissfiris/DB-Project-2024.git
cd DB-Project-2024
```

4. Login to MySQL:

```bash
mysql -u root -p -h localhost
```

5. Run the SQL scripts:

```sql
SOURCE masterchef_DDL.sql;
SOURCE masterchef_DML.sql;
SOURCE create_users.sql;
```

This creates and populates the `masterchef` database.

### 2. Python Scripts (Optional Features)

#### Set up the environment

```bash
python3 -m venv myenv
source myenv/bin/activate
pip install mysql-connector-python pillow
```

#### Run the scripts

- `episode_generator.py`: Creates mock episodes.
- `DB_PIC_INSERT.py`: Inserts images into the `picture` table.
- `show_picture.py`: Displays stored images from the database.

## Sample Use Cases

- Identify chefs with the highest average score.
- Retrieve recipes by difficulty or cuisine.
- Track ingredients and calorie information.
- Determine episode winners and their scores.
- Display photos associated with recipes or episodes.
