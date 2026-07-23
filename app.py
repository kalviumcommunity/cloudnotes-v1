from flask import Flask, render_template, send_from_directory
from api.routes import api_bp
from utils.helpers import init_db
from dotenv import load_dotenv
import os

load_dotenv()

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
UPLOAD_FOLDER = os.path.join(BASE_DIR, "uploads")

app = Flask(__name__)

app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER
app.config["MAX_CONTENT_LENGTH"] = 5 * 1024 * 1024
app.config["SECRET_KEY"] = os.getenv("SECRET_KEY", "dev-fallback-key")
app.register_blueprint(api_bp, url_prefix="/api")

os.makedirs(UPLOAD_FOLDER, exist_ok=True)
init_db()


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
    app.run(debug=True)
