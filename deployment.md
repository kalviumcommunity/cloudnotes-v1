# CloudNotes Deployment

## Architecture
CloudNotes runs as a Dockerized Flask application using Gunicorn and PostgreSQL.

- Application: Flask + Gunicorn
- Database: PostgreSQL 16
- Container orchestration: Docker Compose
- Application port: 5001 (host) → 5000 (container)
- Database persistence: Docker named volume
- Upload persistence: Docker named volume
- Restart policy: always

## Deployment

1. Install Docker Desktop.
2. Create `.env` using `.env.example` and configure the database credentials.
3. Start the application:

   docker compose --env-file .env up -d --build

4. Check services:

   docker compose ps

5. View logs:

   docker compose logs -f

## Access

Open http://localhost:5001

Check the API:

   curl http://localhost:5001/api/notes

## Persistence Test

1. Create a note through the application.
2. Restart the services:

   docker compose restart

3. Check the notes again:

   curl http://localhost:5001/api/notes

The previously created note should still exist because PostgreSQL uses a persistent Docker volume.

## Stop Services

   docker compose down

Do not use `docker compose down -v` when you want to preserve database data.

## Environment Note

This deployment runs through Docker Desktop on the local machine. It uses Docker's Linux container environment; it is not a provisioned Google Compute Engine VM.