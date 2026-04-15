# Conjiweb 鈥?Deployment Guide

## Quick Start (Docker Compose)

```bash
# 1. Clone / unzip the project
cd conjiweb

# 2. Run setup (creates .env, builds, starts all services)
make setup
# or: bash infra/scripts/setup.sh

# 3. Create your first XMPP user
make create-user
# or: docker exec -it conjiweb-prosody prosodyctl adduser alice@localhost

# 4. Open http://localhost and login
```

---

## Services Map

| Service | Container | Internal Port | Exposed Port |
|---------|-----------|---------------|--------------|
| Frontend (Nginx) | conjiweb-web | 80 | via nginx |
| FastAPI Backend | conjiweb-api | 8000 | via nginx |
| PostgreSQL | conjiweb-postgres | 5432 | 5432 (internal) |
| Redis | conjiweb-redis | 6379 | (internal) |
| MinIO | conjiweb-minio | 9000/9001 | 9000, 9001 |
| Prosody XMPP | conjiweb-prosody | 5222/5280 | 5222, 5280 |
| Nginx | conjiweb-nginx | 80/443 | 80, 443 |

---

## Development Mode

Run only the infrastructure in Docker; start frontend and backend locally:

```bash
# Start infra only
make dev

# Terminal 1 鈥?Backend
cd apps/api
pip install -r requirements.txt
cp .env.example .env  # edit if needed
uvicorn app.main:app --reload --port 8000

# Terminal 2 鈥?Frontend
cd apps/web
npm install
npm run dev
# Opens at http://localhost:5173
```

---

## Production Deployment

### Environment Variables

Copy `.env.example` to `.env` and set:

| Variable | Description | Example |
|----------|-------------|---------|
| `POSTGRES_PASSWORD` | Database password | `str0ngP@ss` |
| `REDIS_PASSWORD` | Redis password | `r3d1sP@ss` |
| `MINIO_ROOT_PASSWORD` | MinIO admin password | `m1n10P@ss` |
| `SECRET_KEY` | JWT secret (64 hex chars) | `openssl rand -hex 32` |
| `CORS_ORIGINS` | Allowed frontend origins | `https://chat.example.com` |
| `VITE_API_URL` | API URL seen by browser | `https://api.example.com` |
| `VITE_XMPP_WS_URL` | XMPP WebSocket URL | `wss://xmpp.example.com/xmpp-websocket` |

### Domain Setup (Nginx + HTTPS)

Update `infra/nginx/conf.d/default.conf` with your domains. For HTTPS, use Certbot:

```bash
# Install certbot in nginx container or use Caddy instead
docker exec conjiweb-nginx certbot --nginx -d chat.example.com
```

Or use Cloudflare Tunnel for zero-config HTTPS.

### XMPP Domain Setup

Edit `infra/prosody/prosody.cfg.lua`:
```lua
VirtualHost "your.domain.com"
  authentication = "internal_hashed"

Component "conference.your.domain.com" "muc"
Component "upload.your.domain.com" "http_upload"
```

---

## Database Migrations

```bash
# Apply all migrations
make migrate

# Create a new migration after changing models
make migration name="add_reactions_table"

# Check migration status
cd apps/api && alembic current
```

---

## XMPP User Management

```bash
# Add user
docker exec -it conjiweb-prosody prosodyctl adduser alice@localhost

# Change password
docker exec -it conjiweb-prosody prosodyctl passwd alice@localhost

# Delete user
docker exec -it conjiweb-prosody prosodyctl deluser alice@localhost

# List users
docker exec -it conjiweb-prosody prosodyctl list users localhost

# Check prosody status
docker exec -it conjiweb-prosody prosodyctl status
```

---

## Logs & Monitoring

```bash
# All services
make logs

# Specific service
make logs-api
make logs-xmpp

# Admin API status
curl http://localhost:8000/admin/status

# API docs
make api-docs
```

---

## Backup

```bash
# Backup PostgreSQL
docker exec conjiweb-postgres pg_dump -U conjiweb conjiweb > backup.sql

# Backup MinIO data
docker run --rm -v conjiweb_minio_data:/data -v $(pwd):/backup alpine \
  tar czf /backup/minio-backup.tar.gz /data

# Restore PostgreSQL
cat backup.sql | docker exec -i conjiweb-postgres psql -U conjiweb conjiweb
```

---

## Changing Admin Password

Edit `apps/api/app/api/routers/auth.py`:

```python
# Replace this simple check:
if data.username == "admin" and data.password == "admin":

# With a real check against DB or env var:
import os
if data.username == os.getenv("ADMIN_USER") and data.password == os.getenv("ADMIN_PASS"):
```

Then add `ADMIN_USER` and `ADMIN_PASS` to your `.env`.
