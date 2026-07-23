# CloudNotes: Local Deployment to Compute Engine Mapping

This document maps each piece of the local WSL2 deployment to its equivalent on Google Compute Engine (GCE), with the reasoning for each pairing.

| What I built locally | Compute Engine equivalent | Why they play the same role |
|---|---|---|
| Linux server (Ubuntu 24.04 on WSL2) | Compute Engine VM (e2-medium, Ubuntu) | Both are a real Linux kernel and userspace running the app — WSL2 runs a lightweight Linux VM under Windows, while a GCE instance is a full Linux VM under Google's hypervisor; the app doesn't know or care which one it's on. |
| My terminal / shell (`wsl` from PowerShell) | `gcloud compute ssh` | Both are the entry point an operator uses to reach a remote (or virtualized) Linux shell to run commands, install packages, and manage the service — one connects to a local VM, the other to a cloud VM. |
| `localhost:5000` / WSL's internal IP | VM's static external IP | Both are the network address other machines use to reach the Flask app; locally that's the loopback/WSL-forwarded address, on GCE it's a real public IP routable from the internet. |
| OS firewall (`ufw allow 5000/tcp`) | GCP VPC firewall rule (tcp:5000) | Both are the access-control layer that must explicitly permit inbound traffic on port 5000 before any request reaches the app — without it, the app can be running perfectly and still be unreachable. |
| systemd (`cloudnotes.service`, `Restart=always`, `enabled`) | systemd on the GCE VM | Identical mechanism — GCE Ubuntu images ship systemd too, so the exact same unit file would manage the gunicorn process on the cloud VM, restarting it on crash and at boot. |
| PostgreSQL running locally via `apt install postgresql` | Cloud SQL (managed PostgreSQL) | Both store the same relational data behind the same `psycopg2`/`DATABASE_URL` connection string — locally I run and manage the Postgres process myself, whereas Cloud SQL is the same PostgreSQL engine but with backups, patching, and availability managed by Google. |
| `.env` / environment variables (`DATABASE_URL`, `SECRET_KEY`) | Instance metadata / Secret Manager | Both keep configuration and secrets out of the source code and inject them at runtime — `.env` is read locally via `python-dotenv`, while on GCE the same values would come from instance metadata or Secret Manager instead of a file sitting in the repo. |

## Summary
The application code itself (`app.py`, `api/routes.py`, `utils/helpers.py`) does not change between environments. What changes is only *where* the Linux server, database, and secrets physically live — from a WSL2 VM on a laptop to a managed VM and managed database in GCP.
