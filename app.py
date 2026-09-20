from flask import Flask, render_template, request, redirect, url_for, send_from_directory
from api.routes import api_bp
from utils.helpers import init_db
from dotenv import load_dotenv
import os

# Load environment variables from .env
load_dotenv()

# Base directory
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Read configuration from environment variables
UPLOAD_FOLDER = os.getenv(
    "UPLOAD_FOLDER",
    os.path.join(BASE_DIR, "uploads")
)

DATABASE_URL = os.getenv("DATABASE_URL")

SECRET_KEY = os.getenv("SECRET_KEY", "default-secret-key")

# Create Flask application
app = Flask(__name__)

# Flask configuration
app.secret_key = SECRET_KEY
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER
app.config["DATABASE_URL"] = DATABASE_URL
app.config["MAX_CONTENT_LENGTH"] = 5 * 1024 * 1024

# Register API Blueprint
app.register_blueprint(api_bp, url_prefix="/api")

# Initialize database and uploads folder
@app.before_first_request
def startup():
    init_db(DATABASE_URL)
    os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# Routes
@app.route("/")
def home():
    return render_template("index.html")

@app.route("/notes")
def notes_page():
    return render_template("notes.html")

@app.route("/uploads/<path:filename>")
def uploaded_file(filename):
    return send_from_directory(app.config["UPLOAD_FOLDER"], filename)

# Run the application
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
