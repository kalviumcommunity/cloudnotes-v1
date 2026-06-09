# CloudNotes v1

CloudNotes is a simple local Flask application that runs on a single developer machine.

## Purpose

This repository is an architecture planning assignment starter kit. Students should inspect the project files, understand the current application components, and design a migration plan to a cloud architecture.

## What is included

- A local Flask web application
- HTML templates and static assets
- SQLite database storage
- REST API endpoints
- File uploads saved to a local directory

## Tasks for students

Students should:

1. Review the application structure and source files.
2. Identify the current components and data flow.
3. Create a current architecture diagram.
4. Propose a cloud migration architecture.
5. Map components to cloud services.
6. Analyze risks and architecture decisions.

> Do not deploy or modify the application. This repository is for inspection and planning only.

## Running locally

To run the app locally for inspection:

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app.py
```

Then open `http://127.0.0.1:5000` in a browser.
