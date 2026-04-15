# Conjiweb Docker

Containerized Web XMPP Client Platform — a full-stack, Docker-based, plugin-extensible XMPP client for the web.

## Edition

This repository is the **Docker edition**.

- Docker edition directory: `web_Conji_Dock`
- Native edition directory: `web_Conji_native`

## Architecture

```
Frontend (React + Vite + Tailwind)
    ↕ XMPP WebSocket
Prosody XMPP Server
    ↕ REST API
FastAPI Backend
    ↕ PostgreSQL · Redis · MinIO
```

## Quick Start

```bash
# 1. Clone and enter project
cd web-gajim-v3

# 2. Run setup (creates .env, builds, starts everything)
bash infra/scripts/setup.sh

# 3. Create an XMPP user
docker exec -it wgv3-prosody prosodyctl adduser youruser@localhost

# 4. Open http://localhost and login
```

## Services

| Service    | Port  | Description            |
|------------|-------|------------------------|
| Frontend   | 80    | React web app          |
| API        | 8000  | FastAPI backend        |
| Prosody    | 5222  | XMPP (TCP)             |
| Prosody WS | 5280  | XMPP (WebSocket)       |
| MinIO      | 9000  | Object storage         |
| MinIO UI   | 9001  | MinIO console          |
| PostgreSQL | 5432  | Database               |
| Redis      | 6379  | Cache                  |

## Development

```bash
# Frontend
cd apps/web
npm install
npm run dev

# Backend
cd apps/api
pip install -r requirements.txt
uvicorn app.main:app --reload

# Infra only (for local dev)
docker compose up -d postgres redis minio prosody
```

## Project Structure

```
web-gajim-v3/
├── apps/
│   ├── web/          React frontend
│   └── api/          FastAPI backend
├── packages/
│   ├── plugin-sdk/   Plugin development kit
│   ├── xmpp-adapter/ XMPP protocol wrapper
│   └── shared/       Shared types
├── plugins/          Official plugins
│   ├── ai-summary/
│   ├── translate/
│   └── quick-reply/
├── infra/
│   ├── nginx/        Reverse proxy config
│   ├── prosody/      XMPP server config
│   └── scripts/      Setup scripts
└── docker-compose.yml
```

## Adding a Plugin

1. Create a folder in `plugins/your-plugin/`
2. Implement the `Plugin` interface from `packages/plugin-sdk/src/index.ts`
3. Register via `registerPlugin(yourPlugin)`
4. Enable it in the Admin → Plugins panel

## Default Credentials

- **Admin panel**: `admin` / `admin` (change in `apps/api/app/api/routers/auth.py`)
- **MinIO console**: from `.env` → `MINIO_ROOT_USER` / `MINIO_ROOT_PASSWORD`

## Roadmap

- [x] Project scaffold & Docker
- [x] XMPP adapter (Strophe.js)
- [x] React UI shell (three-panel layout)
- [x] Account management (multi-account)
- [x] Conversation list & message view
- [x] Plugin system scaffold
- [x] AI service endpoints
- [x] File upload (MinIO)
- [x] Admin dashboard
- [ ] OMEMO encryption
- [ ] MAM history pagination
- [ ] Full-text message search
- [ ] PWA / push notifications
- [ ] Plugin marketplace
- [ ] Mobile responsive layout
