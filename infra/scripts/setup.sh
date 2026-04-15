#!/usr/bin/env bash
# Conjiweb - Quick Setup Script
set -e

echo "========================================"
echo "  Conjiweb - Setup"
echo "========================================"

# Check dependencies
command -v docker >/dev/null 2>&1 || { echo "Docker is required but not installed. Aborting."; exit 1; }
command -v docker-compose >/dev/null 2>&1 || command -v "docker compose" >/dev/null 2>&1 || { echo "Docker Compose is required. Aborting."; exit 1; }

# Copy .env if not exists
if [ ! -f .env ]; then
  echo "[1/5] Creating .env from template..."
  cp .env.example .env
  # Generate a random secret key
  SECRET=$(openssl rand -hex 32 2>/dev/null || python3 -c "import secrets; print(secrets.token_hex(32))")
  sed -i.bak "s/replace_with_random_64char_hex/$SECRET/g" .env && rm -f .env.bak
  echo "      .env created. Please review and edit if needed."
else
  echo "[1/5] .env already exists, skipping."
fi

# Build images
echo "[2/5] Building Docker images..."
docker compose build

# Start services
echo "[3/5] Starting services..."
docker compose up -d postgres redis minio prosody

echo "      Waiting for database to be ready..."
sleep 5

# Run migrations (API will auto-create tables on startup)
echo "[4/5] Starting API and web..."
docker compose up -d api web nginx

echo "[5/5] Setup complete!"
echo ""
echo "========================================"
echo "  Services running:"
echo "  Frontend:  http://localhost"
echo "  API:       http://localhost/api"
echo "  MinIO UI:  http://localhost:9001"
echo "  XMPP WS:   ws://localhost/xmpp-websocket"
echo "========================================"
echo ""
echo "  Default admin login: admin / admin"
echo "  (Change this in apps/api/app/api/routers/auth.py)"
echo ""
echo "  To create an XMPP user (Prosody):"
echo "    docker exec -it conjiweb-prosody prosodyctl adduser user@localhost"
echo ""
echo "  View logs:"
echo "    docker compose logs -f"
echo ""
