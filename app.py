from flask import Flask, render_template, send_from_directory
from dotenv import load_dotenv
from api.routes import api_bp
from utils.helpers import init_db
import os

load_dotenv()

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
UPLOAD_FOLDER = os.path.join(BASE_DIR, "uploads")

# Parse database path (SQLite database as indicated by architecture-hints)
DATABASE_URL = os.getenv("DATABASE_URL")
if DATABASE_URL and DATABASE_URL.startswith("sqlite:///"):
    db_path = DATABASE_URL.replace("sqlite:///", "")
elif DATABASE_URL and DATABASE_URL.startswith("postgresql://"):
    db_path = "database/cloudnotes.db"
else:
    db_path = DATABASE_URL or "database/cloudnotes.db"

app = Flask(__name__)

app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER
app.config["DATABASE_URL"] = DATABASE_URL
app.config["DATABASE_PATH"] = os.path.abspath(db_path)
app.config["MAX_CONTENT_LENGTH"] = 5 * 1024 * 1024

app.register_blueprint(api_bp, url_prefix="/api")

with app.app_context():
    init_db(app.config["DATABASE_PATH"])
    os.makedirs(UPLOAD_FOLDER, exist_ok=True)

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/notes")
def notes_page():
    return render_template("notes.html")

@app.route("/uploads/<path:filename>")
def uploaded_file(filename):
    return send_from_directory(app.config["UPLOAD_FOLDER"], filename)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
