import sys
from pathlib import Path
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from app import app


def test_home_page():
    with patch("app.init_db"):
        client = app.test_client()
        response = client.get("/")
        assert response.status_code == 200


def test_notes_page():
    with patch("app.init_db"):
        client = app.test_client()
        response = client.get("/notes")
        assert response.status_code == 200
