from flask import Blueprint, jsonify, request, current_app
from werkzeug.utils import secure_filename
from utils.helpers import get_db_connection, allowed_file
import os

api_bp = Blueprint("api", __name__)


@api_bp.route("/notes", methods=["GET"])
def get_notes():
    conn = get_db_connection(current_app.config["DATABASE_URL"])
    cursor = conn.cursor()
    cursor.execute(
        "SELECT id, title, body, filename, created_at FROM notes ORDER BY created_at DESC"
    )
    rows = cursor.fetchall()

    notes = []
    for row in rows:
        notes.append({
            "id": row[0],
            "title": row[1],
            "body": row[2],
            "filename": row[3],
            "created_at": str(row[4]),
        })

    cursor.close()
    conn.close()

    return jsonify(notes)


@api_bp.route("/notes", methods=["POST"])
def create_note():
    title = request.form.get("title", "Untitled Note")
    body = request.form.get("body", "")
    filename = None

    uploaded_file = request.files.get("attachment")
    if uploaded_file and allowed_file(uploaded_file.filename):
        filename = secure_filename(uploaded_file.filename)
        destination = os.path.join(current_app.config["UPLOAD_FOLDER"], filename)
        uploaded_file.save(destination)

    conn = get_db_connection(current_app.config["DATABASE_URL"])
    cursor = conn.cursor()

    cursor.execute(
        """
        INSERT INTO notes (title, body, filename)
        VALUES (%s, %s, %s)
        RETURNING id
        """,
        (title, body, filename),
    )

    note_id = cursor.fetchone()[0]
    conn.commit()

    cursor.close()
    conn.close()

    return jsonify({
        "id": note_id,
        "title": title,
        "body": body,
        "filename": filename
    }), 201


@api_bp.route("/notes/<int:note_id>", methods=["GET"])
def get_note(note_id):
    conn = get_db_connection(current_app.config["DATABASE_URL"])
    cursor = conn.cursor()

    cursor.execute(
        """
        SELECT id, title, body, filename, created_at
        FROM notes
        WHERE id = %s
        """,
        (note_id,),
    )

    row = cursor.fetchone()

    cursor.close()
    conn.close()

    if row is None:
        return jsonify({"error": "Note not found"}), 404

    return jsonify({
        "id": row[0],
        "title": row[1],
        "body": row[2],
        "filename": row[3],
        "created_at": str(row[4]),
    })


@api_bp.route("/notes/<int:note_id>", methods=["DELETE"])
def delete_note(note_id):
    conn = get_db_connection(current_app.config["DATABASE_URL"])
    cursor = conn.cursor()

    cursor.execute(
        "DELETE FROM notes WHERE id = %s RETURNING id",
        (note_id,),
    )

    deleted = cursor.fetchone()
    conn.commit()

    cursor.close()
    conn.close()

    if deleted is None:
        return jsonify({"error": "Note not found"}), 404

    return jsonify({"message": "Note deleted"}), 200
