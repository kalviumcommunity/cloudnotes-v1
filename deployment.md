# CloudNotes Flask Application Deployment Guide

## Overview

CloudNotes is a Flask REST API application deployed on a Linux environment using production deployment practices.

The deployment stack includes:

- **Ubuntu Linux** as the server environment
- **Gunicorn** as the WSGI application server
- **systemd** for application process management
- **PostgreSQL** as the production database
- **Environment variables** for secure configuration management

Deployment flow:

```
Client
  |
  v
Gunicorn Server
  |
  v
Flask Application
  |
  v
PostgreSQL Database
```

---

# 1. System Requirements

The application requires the following software:

| Software | Purpose |
|---|---|
| Ubuntu Linux | Hosting environment |
| Python 3.12+ | Application runtime |
| PostgreSQL 16 | Database |
| Git | Source code management |
| Gunicorn | Production WSGI server |

Check installed versions:

```bash
python3 --version

psql --version

git --version
```

---

# 2. Clone Repository

Clone the application repository:

```bash
git clone <repository-url>

cd cloudnotes-v1
```

---

# 3. Create Python Virtual Environment

Create an isolated Python environment:

```bash
python3 -m venv venv
```

Activate the environment:

```bash
source venv/bin/activate
```

Install application dependencies:

```bash
pip install -r requirements.txt
```

---

# 4. Environment Configuration

The application uses environment variables to store configuration values.

Create a `.env` file:

```bash
cat > .env << EOF
SECRET_KEY=my-secret-key
DATABASE_URL=postgresql://clouduser:password@localhost:5432/cloudnotes
FLASK_ENV=production
EOF
```

Environment variables are loaded using `python-dotenv`.

Configuration contains:

| Variable | Purpose |
|---|---|
| SECRET_KEY | Flask security key |
| DATABASE_URL | PostgreSQL connection string |
| FLASK_ENV | Production environment |

---

# 5. PostgreSQL Database Setup

Install PostgreSQL:

```bash
sudo apt update

sudo apt install postgresql postgresql-contrib -y
```

Start PostgreSQL:

```bash
sudo systemctl start postgresql
```

Enable PostgreSQL on startup:

```bash
sudo systemctl enable postgresql
```

---

## Create Database and User

Open PostgreSQL:

```bash
sudo -u postgres psql
```

Create database:

```sql
CREATE DATABASE cloudnotes;
```

Create application user:

```sql
CREATE USER clouduser WITH PASSWORD 'password';
```

Grant permissions:

```sql
GRANT ALL PRIVILEGES ON DATABASE cloudnotes TO clouduser;
```

Exit:

```sql
\q
```

---

## Verify Database Connection

Connect:

```bash
psql postgresql://clouduser:password@localhost:5432/cloudnotes
```

Check tables:

```sql
\dt
```

---

# 6. Database Initialization

When the Flask application starts, it initializes the required database schema.

Database table:

```
notes
 |
 |-- id
 |-- title
 |-- body
 |-- filename
 |-- created_at
```

The application uses PostgreSQL instead of SQLite for production deployment.

---

# 7. Running Application Manually

## Development Mode

Run Flask directly:

```bash
python app.py
```

The application starts on:

```
http://localhost:5000
```

---

## Production Mode

Run using Gunicorn:

```bash
gunicorn --bind 0.0.0.0:5000 app:app
```

Explanation:

| Command | Purpose |
|-|-|
| gunicorn | Production application server |
| --bind | Exposes server address |
| app:app | Flask application object |

---

# 8. systemd Service Deployment

`systemd` keeps the application running in production.

Create service file:

```bash
sudo nano /etc/systemd/system/cloudnotes.service
```

Add:

```ini
[Unit]
Description=CloudNotes Flask Application
After=network.target

[Service]
User=megha
WorkingDirectory=/home/megha/cloudnotes-v1

EnvironmentFile=/home/megha/cloudnotes-v1/.env

ExecStart=/home/megha/cloudnotes-v1/venv/bin/gunicorn \
--bind 0.0.0.0:5000 \
app:app

Restart=always

[Install]
WantedBy=multi-user.target
```

---

## Enable Service

Reload systemd:

```bash
sudo systemctl daemon-reload
```

Enable application startup:

```bash
sudo systemctl enable cloudnotes
```

Start application:

```bash
sudo systemctl start cloudnotes
```

---

## Check Application Status

```bash
systemctl status cloudnotes
```

Expected output:

```
Active: active (running)
```

---

# 9. API Request Paths

The deployed application exposes the following endpoints.

---

# Home Page

## Request

```
GET /
```

Example:

```bash
curl http://localhost:5000/
```

Returns the application homepage.

---

# Notes Page

## Request

```
GET /notes
```

Example:

```bash
curl http://localhost:5000/notes
```

Displays notes interface.

---

# Get All Notes

## Request

```
GET /api/notes
```

Example:

```bash
curl http://localhost:5000/api/notes
```

Response example:

```json
[
 {
   "id":1,
   "title":"Test Note",
   "body":"Hello CloudNotes"
 }
]
```

---

# Create Note

## Request

```
POST /api/notes
```

Example:

```bash
curl -X POST \
-F title="Test Note" \
-F body="Hello CloudNotes" \
http://localhost:5000/api/notes
```

Creates a new note.

---

# Get Single Note

## Request

```
GET /api/notes/<id>
```

Example:

```bash
curl http://localhost:5000/api/notes/1
```

---

# Delete Note

## Request

```
DELETE /api/notes/<id>
```

Example:

```bash
curl -X DELETE \
http://localhost:5000/api/notes/1
```

Deletes the selected note.

---

# 10. Deployment Verification Checklist

## Check Service

```bash
systemctl status cloudnotes
```

Expected:

```
Active: active (running)
```

---

## Check Gunicorn Process

```bash
ps aux | grep gunicorn
```

---

## Test API

```bash
curl http://localhost:5000/api/notes
```

---

## Check Database

Connect:

```bash
psql postgresql://clouduser:password@localhost:5432/cloudnotes
```

View tables:

```sql
\dt
```

---

# 11. Production Deployment Architecture

```
                 User
                  |
                  v
          Linux Server / VM
                  |
                  v
             Gunicorn
                  |
                  v
          Flask Application
             /        \
            /          \
           v            v
    PostgreSQL       File Storage
      Database        uploads/
```

---

# 12. Cloud Deployment Mapping

The Linux deployment can be migrated to Google Cloud Platform:

| Current Component | Google Cloud Equivalent |
|---|---|
| Ubuntu Linux Server | Compute Engine VM |
| Gunicorn + Flask | Application running on VM |
| PostgreSQL | Cloud SQL PostgreSQL |
| `.env` configuration | Secret Manager |
| Upload directory | Cloud Storage Bucket |
| Server networking | External IP + Firewall Rules |

This architecture provides:

- Managed database backups
- Scalable storage
- Secure secret management
- Reliable application hosting
