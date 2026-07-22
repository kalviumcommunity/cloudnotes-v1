# CloudNotes Deployment Documentation

## Environment

- Host machine: macOS, using Multipass to run an Ubuntu 24.04 LTS virtual machine (`cloudnotes-vm`).
- VM IP address: 192.168.252.2 (assigned automatically by Multipass's bridged-style network adapter).
- App: Flask (CloudNotes), served via gunicorn, managed by systemd as `cloudnotes.service`.

## Request path (browser to Flask)

1. **Your browser** sends an HTTP request to `http://192.168.252.2:5000`.
2. **Host / VM network**: Multipass gives the VM its own IP address on a virtual network shared with the Mac host, so the request is routed directly to the VM without needing NAT port-forwarding (unlike VirtualBox's default NAT mode).
3. **OS firewall / open port**: `ufw` (Ubuntu's firewall) is active on the VM and has an explicit `ALLOW IN` rule for `5000/tcp`, so the incoming connection is permitted through to the OS network stack.
4. **Linux server**: the Ubuntu VM's kernel accepts the TCP connection and hands it to whichever process is listening on port 5000.
5. **Flask on 0.0.0.0:5000**: gunicorn (running under systemd) is bound to `0.0.0.0:5000`, meaning it listens on all network interfaces, not just localhost. Gunicorn imports the Flask `app` object from `app.py` and passes the request to it, which routes it to the matching view function and returns the rendered response back down the same path to the browser.

## Setup commands used

### Firewall configuration
    sudo ufw allow OpenSSH
    sudo ufw allow 5000/tcp
    sudo ufw enable
    sudo ufw status verbose

### Environment variables
- `.env` created locally on the VM (NOT committed) containing:
    SECRET_KEY=<randomly generated via `python3 -c "import secrets; print(secrets.token_hex(32))"`>
    DATABASE_PATH=/home/ubuntu/cloudnotes-v1/database/cloudnotes.db
- `.env.example` committed to the repo with placeholder values for both keys.
- `app.py` updated to call `load_dotenv()` on startup and read `SECRET_KEY` / `DATABASE_PATH` via `os.environ.get(...)`, each with a safe fallback default.
- `.gitignore` updated to add a `.env` entry so the real file is never committed.

### Verifying it works
    curl http://192.168.252.2:5000
    # returns the CloudNotes homepage HTML

    python3 -c "
    import os
    from dotenv import load_dotenv
    load_dotenv()
    print('SECRET_KEY from env:', os.environ.get('SECRET_KEY'))
    print('DATABASE_PATH from env:', os.environ.get('DATABASE_PATH'))
    "
    # confirms values are read from .env, not hardcoded defaults
