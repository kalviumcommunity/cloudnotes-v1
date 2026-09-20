# CloudNotes Cloud Mapping

## 1. Current Deployment

CloudNotes is currently deployed in an Ubuntu WSL2 environment.

The application uses Flask, Gunicorn, systemd, PostgreSQL 16, and `.env` for configuration.

## 2. Google Cloud Compute Engine Mapping

| Current Environment | Google Cloud Equivalent |
|---|---|
| Ubuntu WSL2 | Ubuntu Compute Engine VM |
| Linux filesystem | VM persistent disk |
| Gunicorn | Gunicorn on the Compute Engine VM |
| systemd | systemd on the Compute Engine VM |
| Port 5000 | VPC firewall rule allowing required application traffic |
| PostgreSQL | Cloud SQL for PostgreSQL |
| `.env` | Environment configuration / Secret Manager |

## 3. Application Server

The Flask application is served by Gunicorn:

    gunicorn --bind 0.0.0.0:5000 app:app

On Google Compute Engine, the same Gunicorn command can run on the VM.

The systemd service can automatically start Gunicorn and restart it after an unexpected failure.

## 4. Database Mapping

The current deployment uses PostgreSQL 16.

For a cloud deployment, PostgreSQL can be moved to Google Cloud SQL for PostgreSQL.

The application would connect to Cloud SQL using the DATABASE_URL environment variable.

This separates the application server from the database and provides a managed database service.

## 5. Networking

The current application listens on 0.0.0.0:5000.

In Google Cloud, the Compute Engine VM would use a VPC network.

A firewall rule would allow only the required inbound application traffic to the VM.

The PostgreSQL database should not be exposed directly to the public internet. Database access should be restricted to the application environment.

## 6. Persistence

The current PostgreSQL database provides persistent storage for CloudNotes notes.

In Google Cloud, Cloud SQL provides managed PostgreSQL storage, while Compute Engine provides the application runtime.

## 7. Secrets and Configuration

The local deployment uses the DATABASE_URL environment variable.

The `.env` file is excluded from Git.

For a production Google Cloud deployment, sensitive database credentials should be stored using Google Cloud Secret Manager rather than committed to the repository.

## 8. High-Level Cloud Architecture

User → Google Compute Engine VM → systemd → Gunicorn → Flask CloudNotes → Cloud SQL PostgreSQL

The WSL2 deployment demonstrates the Linux application-server architecture locally, while the cloud mapping shows how the same components can be deployed using Google Cloud services.
