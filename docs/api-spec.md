# Conjiweb 鈥?API Reference

Base URL: `http://localhost:8000` (dev) or `https://api.yourdomain.com` (prod)

Interactive docs: `GET /docs` (Swagger UI)

---

## Auth

### POST /auth/admin/login
Login to admin panel.
```json
Body: { "username": "admin", "password": "admin" }
Response: { "access_token": "...", "token_type": "bearer" }
```

---

## Accounts

### GET /accounts/
List all enabled accounts.

### POST /accounts/
Create account config.
```json
Body: { "jid": "user@example.com", "domain": "example.com", "display_name": "Alice" }
```

### GET /accounts/{id}
Get single account.

### DELETE /accounts/{id}
Soft-delete account (sets is_enabled=false).

---

## Conversations

### GET /conversations/?account_id=...
List conversations for an account, ordered by last message.

### POST /conversations/
Create or get existing conversation.
```json
Body: { "account_id": "...", "type": "private", "peer_jid": "bob@example.com", "title": "Bob" }
```

### PATCH /conversations/{id}/pin?pinned=true
Pin or unpin conversation.

### PATCH /conversations/{id}/archive?archived=true
Archive or unarchive conversation.

### PATCH /conversations/{id}/read
Mark conversation as read (unread_count=0).

---

## Contacts

### GET /contacts/?account_id=...
List contacts for an account.

### POST /contacts/
Upsert contact.
```json
Body: { "account_id": "...", "jid": "bob@example.com", "nickname": "Bob", "group_name": "Friends" }
```

### PATCH /contacts/{id}/block?blocked=true
Block or unblock a contact.

### DELETE /contacts/{id}
Remove contact.

---

## Messages

### POST /messages/
Index a message into the backend search store.
```json
Body: {
  "conversation_id": "...",
  "sender_jid": "alice@example.com",
  "body": "Hello!",
  "direction": "out",
  "body_type": "text"
}
```

### GET /messages/search?q=hello&limit=20
Full-text search across all indexed messages.

### GET /messages/conversation/{id}?limit=50&offset=0
Get messages for a conversation (newest first).

---

## Attachments

### POST /attachments/upload
Upload file to MinIO.
```
Content-Type: multipart/form-data
Fields: file (required), message_id (optional)
Response: { "id": "...", "object_key": "...", "download_url": "...", ... }
```

### GET /attachments/presign/{object_key}
Get a pre-signed download URL.
```
Response: { "url": "https://..." }
```

---

## Plugins

### GET /plugins/
List all plugins with enable status.

### POST /plugins/{id}/enable
Enable a plugin.

### POST /plugins/{id}/disable
Disable a plugin.

---

## AI

### POST /ai/summarize
Summarize a list of messages.
```json
Body: { "messages": ["Hello", "How are you?", ...], "conversation_id": "..." }
Response: { "summary": "...", "key_points": ["..."] }
```

### POST /ai/translate?text=Hello&target_lang=zh
Translate a message. Connect a translation API to activate.

### POST /ai/smart-reply?message=Hello
Get smart reply suggestions.
```json
Response: { "suggestions": ["OK!", "Thanks!", "..."] }
```

---

## Admin

### GET /admin/status
System health and statistics.
```json
Response: {
  "status": "healthy",
  "version": "3.0.0",
  "stats": { "accounts": 2, "messages": 1500, "attachments": 42 }
}
```

### GET /admin/audit-logs?limit=50&offset=0
Retrieve audit log entries.

---

## WebSocket

### WS /ws/{account_id}
Real-time push channel for server-originated events.

Messages from server:
- `{ "type": "connected", "account_id": "..." }`
- `{ "type": "ping" }`
- `{ "type": "ai.job.completed", "job_id": "...", "result": {...} }`
- `{ "type": "plugin.event", "plugin_id": "...", "payload": {...} }`

Messages from client:
- `{ "type": "ping" }` 鈫?server responds with `{ "type": "pong" }`
