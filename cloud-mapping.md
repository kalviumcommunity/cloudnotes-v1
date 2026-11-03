# CloudNotes Cloud Infrastructure Mapping

| Current Deployment | Google Cloud Equivalent |
|---|---|
| Dockerized Flask application | Compute Engine VM |
| Docker Compose | Docker Compose installed on the VM |
| Gunicorn | Application process server |
| PostgreSQL container | Cloud SQL for PostgreSQL |
| PostgreSQL Docker volume | Cloud SQL managed storage |
| Uploads Docker volume | Persistent Disk or Cloud Storage |
| Docker restart policy | systemd service or VM restart policy |
| Local environment variables | Secret Manager |
| Docker logs | Cloud Logging |
| Local port 5001 | VM external IP with an appropriate firewall rule |

## Request Flow

1. A user accesses the application through a browser.
2. The request reaches the Flask application running through Gunicorn.
3. Flask processes the request and communicates with PostgreSQL.
4. PostgreSQL stores application data persistently.
5. The application returns the response to the browser.

## Deployment Scope

The current implementation demonstrates Docker-based deployment using a Linux container environment on Docker Desktop. The Google Cloud services listed above are infrastructure equivalents for a future cloud deployment. A Google Compute Engine VM and Cloud SQL instance have not been provisioned as part of this implementation.