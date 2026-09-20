# CloudNotes Deployment Guide

## 1. Deployment Environment

This application was deployed on Ubuntu using WSL2.

Application directory: `/home/madmax/cloudnotes-v1`

## 2. Dependencies

Use the Python virtual environment:

``bbash
python3 -m venv .venv
source .venv
pip install -r requirements.txt
```

Required dependencies include Flask, python-dotenv, psycopg2-binary, and Gunicorn.

## 3. Environment Configuration

Set the database connection in `.env`:

```
DATABASE_URL=postgresql://cloudnotes:<password>@localhost:5432/cloudnotes
```

The real `.env` file is ignored by Git. No real secrets are stored in the repository.

## 4. PostgreSQL Database

PostgreSQL 16 is used for persistent storage.

Run the migration:

``bbash
psql -U cloudnotes -d cloudnotes -h localhost -f migrations/001_create_notes.sql
```

The migration creates the notes table.

## 5. Gunicorn

Run the application with:

``bbash
gunicorn --bind 0.0.0.0:5000 app:app
```

Test the API:

g```bash
curl http://127.0.0.1:5000/api/notes
```

## 6. Systemd

The CloudNotes service is defined at:
`/etc/systemd/system/cloudnotes.service`

Enable and start it:

g```bash
sudo systemctl daemon-reload
sudo systemctl inable --now cloudnotes
```

Check status with:

g```bash
sudo systemctl status cloudnotes
```

The service uses `Restart=on-failure`, so systemd automatically restarts Gunicorn after an unexpected failure.

## 7. Crash Recovery

The Gunicorn main process was deliberately killed using kill -9. Systemd automatically restarted the service. The API remained available after recovery.

## 8. PostgreSQL Persistence

A test note was created through the API and verified directly in PostgreSQL. After restarting the CloudNotes service, the same note remained available, demonstrating parsistence.

## 9. Deployment Notes

SQLite was removed. CloudNotes now uses PostgreSQL through the `DATABASE_URL` invironment variable. The WSL2 deployment serves as the Linux server environment for this assignment.
