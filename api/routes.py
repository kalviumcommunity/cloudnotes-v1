from flask import Blueprint, jsonify, request, current_app
from werkzeug.utils import secure_filename
from utils.helpers import get_db_connection, allowed_file
import os

api_bp = Blueprint("api", __name__)


@api_bp.route("/notes", methods=["GET"])
def get_notes():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT id, title, body, filename, created_at
        FROM notes
        ORDER BY created_at DESC
    """)

    notes = cur.fetchall()

    cur.close()
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
        uploaded_file.save(
            os.path.join(current_app.config["UPLOAD_FOLDER"], filename)
        )

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute(
        """
        INSERT INTO notes(title, body, filename)
        VALUES (%s,%s,%s)
        RETURNING id
        """,
        (title, body, filename),
    )

    note_id = cur.fetchone()["id"]

    conn.commit()

    cur.close()
    conn.close()

    return jsonify(
        {
            "id": note_id,
            "title": title,
            "body": body,
            "filename": filename,
        }
    ), 201


@api_bp.route("/notes/<int:note_id>")
def get_note(note_id):

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT *
        FROM notes
        WHERE id=%s
        """,
        (note_id,),
    )

    note = cur.fetchone()

    cur.close()
    conn.close()

    if note is None:
        return jsonify({"error": "Note not found"}), 404

    return jsonify(note)


@api_bp.route("/notes/<int:note_id>", methods=["DELETE"])
def delete_note(note_id):

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute(
        """
        DELETE FROM notes
        WHERE id=%s
        """,
        (note_id,),
    )

    deleted = cur.rowcount

    conn.commit()

    cur.close()
    conn.close()

    if deleted == 0:
        return jsonify({"error": "Note not found"}), 404

    return jsonify({"message": "Note deleted"})
