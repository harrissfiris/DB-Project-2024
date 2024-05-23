from PIL import Image
import mysql.connector
import io

# Σύνδεση στη βάση δεδομένων
db = mysql.connector.connect(
    host="localhost",
    user="admin",
    password="admin",
    database="masterchef"
)

cursor = db.cursor()

# Διαβάζοντας την εικόνα και μετατρέποντάς την σε δυαδική μορφή
file_path = '/Users/harrissfiris/Desktop/Pictures/them_unit.jpg'
with open(file_path, "rb") as file:
    binary_data = file.read()

# Συμπληρώνετε τις επιθυμητές τιμές για το picture_id και την περιγραφή
picture_id = 20010
description = "picture of friends eating different foods"

# Δημιουργία SQL εντολής για την εισαγωγή δεδομένων
sql = "INSERT INTO picture (picture_id, description, pic) VALUES (%s, %s, %s)"
val = (picture_id, description, binary_data)

# Εκτέλεση της εντολής και αποθήκευση των αλλαγών
cursor.execute(sql, val)
db.commit()

print(cursor.rowcount, "record inserted.")

# Κλείσιμο της σύνδεσης
cursor.close()
db.close()
