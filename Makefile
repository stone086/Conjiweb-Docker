.PHONY: dev prod setup stop logs clean create-user api-docs

# ── Development ────────────────────────────────────────────
dev:
	docker compose -f docker-compose.dev.yml up -d
	@echo ""
	@echo "Infrastructure running. Now start your dev servers:"
	@echo "  Backend:  cd apps/api && uvicorn app.main:app --reload"
	@echo "  Frontend: cd apps/web && npm run dev"

# ── Production ─────────────────────────────────────────────
prod:
	docker compose up -d --build

setup:
	bash infra/scripts/setup.sh

stop:
	docker compose down

stop-dev:
	docker compose -f docker-compose.dev.yml down

# ── Logs ───────────────────────────────────────────────────
logs:
	docker compose logs -f

logs-api:
	docker compose logs -f api

logs-xmpp:
	docker compose logs -f prosody

# ── Database ───────────────────────────────────────────────
migrate:
	cd apps/api && alembic upgrade head

migration:
	cd apps/api && alembic revision --autogenerate -m "$(name)"

# ── XMPP Users ─────────────────────────────────────────────
create-user:
	@read -p "JID (e.g. alice@localhost): " jid; \
	docker exec -it wgv3-prosody prosodyctl adduser $$jid

list-users:
	docker exec -it wgv3-prosody prosodyctl list users localhost

delete-user:
	@read -p "JID to delete: " jid; \
	docker exec -it wgv3-prosody prosodyctl deluser $$jid

# ── API ────────────────────────────────────────────────────
api-docs:
	@echo "API docs: http://localhost:8000/docs"
	@open http://localhost:8000/docs 2>/dev/null || xdg-open http://localhost:8000/docs

# ── Clean ──────────────────────────────────────────────────
clean:
	docker compose down -v
	docker compose -f docker-compose.dev.yml down -v

clean-images:
	docker rmi wgv3-web wgv3-api 2>/dev/null || true
