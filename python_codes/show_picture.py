import mysql.connector
from PIL import Image
import io

# Σύνδεση στη βάση δεδομένων
db = mysql.connector.connect(
    host="localhost",
    user="admin",
    password="admin",
    database="masterchef"
)

cursor = db.cursor()

# Ερώτημα για την ανάκτηση της εικόνας
sql = "SELECT pic FROM picture WHERE picture_id = 20005"
cursor.execute(sql)

# Αποθήκευση του δυαδικού περιεχομένου σε μεταβλητή
data = cursor.fetchone()[0]

# Δημιουργία ενός αντικειμένου εικόνας από τα δυαδικά δεδομένα
image = Image.open(io.BytesIO(data))
image.show()

# Κλείσιμο της σύνδεσης
cursor.close()
db.close()
