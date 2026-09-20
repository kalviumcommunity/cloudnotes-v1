import psycopg2

SCHEMA = """
CREATE TABLE IF NOT EXISTS notes (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    filename TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
"""

ALLOWED_EXTENSIONS = {"txt", "md", "pdf", "png", "jpg", "jpeg", "gif"}

def get_db_connection(database_url):
    return psycopg2.connect(database_url)

def init_db(database_url):
    conn = get_db_connection(database_url)
    cursor = conn.cursor()
    cursor.execute(SCHEMA)
    conn.commit()
    cursor.close()
    conn.close()

def allowed_file(filename):
    return "." in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS
