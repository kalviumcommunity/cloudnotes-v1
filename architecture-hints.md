This repository contains a local Flask web application.

The application entry point is `app.py`.
HTML templates are stored in `templates/`.
Static content is grouped under `static/`.
Uploaded files are written to the `uploads/` directory.
PostgreSQL is used as the application database.
REST API routes are implemented under `api/routes.py`.
Helper functions for database access are in `utils/helpers.py`.

The application is deployed as a Gunicorn service managed by systemd.
The systemd service definition is located at `/etc/systemd/system/cloudnotes.service`.
Database configuration is provided through the `DATABASE_URL` environment variable.
