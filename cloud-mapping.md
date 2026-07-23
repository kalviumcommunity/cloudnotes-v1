# Cloud Mapping - Linux Deployment to Google Cloud Platform

## Overview

The CloudNotes application is currently deployed on a Linux environment using Flask, Gunicorn, systemd, and PostgreSQL.

This document explains how each component in the Linux deployment maps to equivalent Google Cloud Platform (GCP) services.

The migration goal is to move from a self-managed Linux server to a scalable cloud architecture.

---

# Current Linux Architecture

```
                  User
                   |
                   v
            Linux Server
                   |
                   v
              Gunicorn
                   |
                   v
          Flask Application
              /        \
             /          \
            v            v
     PostgreSQL       uploads/
      Database        Storage
```

---

# 1. Linux Server → Compute Engine

## Current Implementation

```
Ubuntu Linux Machine
```

The Linux server hosts:

- Flask application
- Gunicorn server
- systemd service
- Application dependencies

---

## Google Cloud Equivalent

```
Google Compute Engine VM Instance
```

---

## Purpose

Compute Engine provides a virtual machine where the application can run.

Responsibilities:

- Host Flask application
- Run Gunicorn server
- Provide networking
- Manage application runtime environment

---

## Mapping

| Linux Component | GCP Equivalent |
|---|---|
| Ubuntu Server | Compute Engine VM |
| Server IP Address | External IP Address |
| Linux Packages | Installed VM dependencies |
| Application Process | Running service on VM |

---

# 2. Flask Application + Gunicorn → Compute Engine Application Layer

## Current Implementation

```
Gunicorn
    |
    v
Flask Application
```

Gunicorn acts as the production WSGI server that handles HTTP requests and forwards them to Flask.

---

## Google Cloud Equivalent

```
Compute Engine VM running Gunicorn + Flask
```

---

## Purpose

The VM continues to run the application stack.

Request flow:

```
User Request
      |
      v
External IP
      |
      v
Gunicorn
      |
      v
Flask Routes
      |
      v
Application Logic
```

---

# 3. systemd → VM Process Management

## Current Implementation

```
systemd
```

systemd manages the Flask application lifecycle.

Features:

- Starts application automatically
- Restarts application after failure
- Runs application after server reboot

---

## Google Cloud Equivalent

```
systemd inside Compute Engine VM
```

---

## Purpose

Even after migration to cloud, systemd can continue managing application processes.

Example:

```
Compute Engine VM
        |
        v
systemd
        |
        v
Gunicorn
        |
        v
Flask Application
```

---

# 4. PostgreSQL Database → Cloud SQL

## Current Implementation

```
PostgreSQL installed on Linux Server
```

The application stores notes data in PostgreSQL.

---

## Google Cloud Equivalent

```
Cloud SQL for PostgreSQL
```

---

## Purpose

Cloud SQL provides a managed PostgreSQL database.

Benefits:

- Automated backups
- Database monitoring
- Security management
- High availability
- Easy scaling

---

## Mapping

| Current | Cloud |
|-|-|
| Local PostgreSQL | Cloud SQL PostgreSQL |
| Database user | Cloud SQL user |
| Connection URL | Cloud SQL connection string |

---

## Database Flow

```
Flask Application
        |
        v
Cloud SQL PostgreSQL
        |
        v
Notes Data
```

---

# 5. Environment Variables → Secret Manager

## Current Implementation

```
.env file
```

Example:

```
SECRET_KEY=my-secret-key

DATABASE_URL=postgresql://...
```

---

## Problem

Keeping secrets inside files can create security risks.

---

## Google Cloud Equivalent

```
Google Secret Manager
```

---

## Purpose

Secret Manager securely stores:

- Database passwords
- API keys
- Application secrets
- Configuration values

---

## Mapping

| Current | GCP |
|-|-|
| .env file | Secret Manager |
| SECRET_KEY | Stored secret |
| Database password | Stored secret |

---

# 6. Upload Storage → Cloud Storage

## Current Implementation

```
uploads/
```

Files are stored locally on the server.

---

## Problem

Local storage:

- Limited disk space
- Lost if VM is deleted
- Difficult to scale

---

## Google Cloud Equivalent

```
Cloud Storage Bucket
```

---

## Purpose

Cloud Storage provides scalable object storage.

Used for:

- Uploaded files
- Documents
- Images
- Attachments

---

## File Flow

```
User Upload
     |
     v
Flask Application
     |
     v
Cloud Storage Bucket
```

---

# 7. Networking → External IP and Firewall Rules

## Current Implementation

```
localhost:5000
```

The application is accessed through the Linux machine.

---

## Google Cloud Equivalent

```
External IP Address
+
VPC Firewall Rules
```

---

## Purpose

Allows users to access the application securely.

Example:

```
User
 |
 v
External IP:5000
 |
 v
Compute Engine VM
 |
 v
Flask Application
```

---

# 8. Complete Google Cloud Architecture

```
                         Users
                           |
                           v
                 External IP Address
                           |
                           v
              Compute Engine VM Instance
                           |
              -------------------------
              |                       |
              v                       v
          Gunicorn              systemd
              |
              v
        Flask Application
              |
      ---------------------
      |                   |
      v                   v
 Cloud SQL           Cloud Storage
 PostgreSQL          Bucket

              |
              v

        Secret Manager
```

---

# 9. Component Comparison Table

| Linux Deployment | Google Cloud Service | Purpose |
|-|-|-|
| Ubuntu Server | Compute Engine | Application hosting |
| Flask + Gunicorn | Compute Engine VM | API execution |
| systemd | systemd on VM | Process management |
| PostgreSQL | Cloud SQL PostgreSQL | Managed database |
| .env file | Secret Manager | Secure configuration |
| uploads folder | Cloud Storage | File storage |
| localhost/IP | External IP + Firewall | Network access |

---

# 10. Benefits of Cloud Migration

Moving CloudNotes to Google Cloud provides:

## Reliability

- Automatic backups
- Managed infrastructure
- Better fault tolerance

## Security

- Secure secret storage
- Controlled network access
- Managed database security

## Scalability

- Increase VM resources when traffic grows
- Scale database independently
- Store unlimited files using Cloud Storage

## Maintainability

- Less server management
- Easier monitoring
- Production-ready infrastructure
