# CloudNotes Deployment

## Environment
Ubuntu 24.04 running under WSL2 on Windows, with systemd enabled (`/etc/wsl.conf` sets `systemd=true`).

## Setup Commands
```bash
sudo apt update
sudo apt install -y python3 python3-venv python3-pip postgresql ufw
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Database Setup (PostgreSQL)
```bash
sudo -u postgres psql -c "CREATE USER clouduser WITH PASSWORD 'cloud123';"
sudo -u postgres psql -c "CREATE DATABASE cloudnotes OWNER clouduser;"
```
Connection string is read from `DATABASE_URL` in `.env` (see `.env.example`).

## Running the App
Managed by systemd — see `cloudnotes.service`. Manual equivalent for testing:
```bash
gunicorn --bind 0.0.0.0:5000 app:app
```

## Managed Service
```bash
sudo cp cloudnotes.service /etc/systemd/system/cloudnotes.service
sudo systemctl daemon-reload
sudo systemctl enable cloudnotes
sudo systemctl start cloudnotes
```
`Restart=always` recovers the process on crash. `enabled` plus `WantedBy=multi-user.target` starts it automatically on boot. `Requires=postgresql.service` ensures it waits for the database to be ready before starting, avoiding a boot-time race condition.

## Opening the Port
```bash
sudo ufw allow 5000/tcp
sudo ufw enable
```

## Browser Access
The application is accessible at:
http://localhost:5000

## Request Path
```
Browser (Windows host)
  -> WSL2 virtual network / localhost forwarding
  -> OS firewall (ufw, port 5000/tcp open)
  -> Linux server (Ubuntu on WSL2)
  -> Flask app bound to 0.0.0.0:5000 (served via gunicorn)
```
