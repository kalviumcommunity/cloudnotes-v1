# CloudNotes Deployment Guide

## Environment

- Ubuntu 24.04
- Python 3.12
- Gunicorn
- Nginx
- systemd

## Installation

Clone repository

```bash
git clone <repository-url>
cd cloudnotes-v1
```

Create virtual environment

```bash
python3 -m venv venv
source venv/bin/activate
```

Install dependencies

```bash
pip install -r requirements.txt
```

Run Gunicorn

```bash
gunicorn --bind 0.0.0.0:5000 app:app
```

Create systemd service

```bash
sudo cp deployment/cloudnotes.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable cloudnotes
sudo systemctl start cloudnotes
```

Configure Nginx

```bash
sudo cp deployment/nginx.conf /etc/nginx/sites-available/cloudnotes
sudo ln -s /etc/nginx/sites-available/cloudnotes /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## Access

Application

```
http://localhost
```

API

```
http://localhost/api/notes
```
