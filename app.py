from flask import Flask, render_template, request, redirect, url_for
import mysql.connector
from werkzeug.security import generate_password_hash

app = Flask(__name__)

# Configure MySQL connection
db = mysql.connector.connect(
    host="mysql-db",
    user="root",
    password="root",
    database="user_db"
)
cursor = db.cursor()

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/signup", methods=["POST"])
def signup():
    email = request.form["email"]
    password = request.form["password"]
    repeat_password = request.form["repeat_password"]

    if password != repeat_password:
        return "~]~L Passwords do not match!"

    hashed_password = generate_password_hash(password)

    try:
        cursor.execute("INSERT INTO users (email, password) VALUES (%s, %s)", (email, hashed_password))
        db.commit()
        return redirect(url_for('dashboard'))
    except mysql.connector.Error as err:
        return f"~]~L Error: {err}"

@app.route("/dashboard")
def dashboard():
    return render_template("dashboard.html")

@app.route("/save_profile", methods=["POST"])
def save_profile():
    full_name = request.form["full_name"]
    preferred_role = request.form["preferred_role"]
    skills = request.form["skills"]
    linkedin = request.form["linkedin"]


    cursor.execute( "INSERT INTO user_profiles (full_name, preferred_role, skills, linkedin) VALUES (%s, %s, %s, %s)", (full_name, preferred_role, skills, linkedin))
    db.commit()

    # Example: You can save this into another table (not implemented here)
    print("Profile saved:", full_name, preferred_role, skills, linkedin)
    return f"~\~E Thank you {full_name}! Your profile has been saved."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
