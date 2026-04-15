# Web Gajim V3 — Architecture Documentation

## Overview

Web Gajim V3 is a seven-layer full-stack XMPP web client platform.

```
┌─────────────────────────────────────────────────────┐
│  Layer 1: Presentation                              │
│  React 18 + TypeScript + Tailwind CSS + Vite        │
├─────────────────────────────────────────────────────┤
│  Layer 2: Application State                         │
│  Zustand + TanStack Query + IndexedDB (Dexie.js)    │
├─────────────────────────────────────────────────────┤
│  Layer 3: XMPP Adapter                              │
│  XmppClient (Strophe.js wrapper) + xmppBridge       │
├─────────────────────────────────────────────────────┤
│  Layer 4: Business API                              │
│  FastAPI + SQLAlchemy + Alembic + WebSocket         │
├─────────────────────────────────────────────────────┤
│  Layer 5: Data                                      │
│  PostgreSQL (primary) + Redis (cache) + IndexedDB   │
├─────────────────────────────────────────────────────┤
│  Layer 6: Object Storage                            │
│  MinIO (S3-compatible file storage)                 │
├─────────────────────────────────────────────────────┤
│  Layer 7: XMPP Server                               │
│  Prosody (XMPP, MUC, MAM, HTTP Upload, WebSocket)  │
└─────────────────────────────────────────────────────┘
```

## Frontend Architecture

### State Management
- **accountStore** (Zustand + persist): Multi-account XMPP credentials, connection status, presence
- **chatStore** (Zustand): Active conversations, messages (in-memory), unread counts
- **rosterStore** (Zustand + persist): Contacts, presence, block list
- **notificationStore** (Zustand + persist): Notification queue, sound/browser settings
- **groupStore** (Zustand + persist): MUC rooms, members

### Services
- **xmppAdapter.ts**: `XmppClient` class wrapping Strophe.js. One instance per account.
- **xmppBridge.ts**: Wires XmppClient events into Zustand stores + notifications.
- **apiSocket.ts**: WebSocket client for FastAPI push events (AI jobs, admin alerts).
- **api.ts**: Axios-based REST client for all FastAPI endpoints.
- **localDb.ts**: Dexie.js IndexedDB for offline cache (messages, conversations, contacts).

### Key Hooks
- **useTypingIndicator**: Sends/receives XEP-0085 composing state.
- **useMAM**: Fetches MAM (XEP-0313) message archive with pagination.
- **useXmppReconnect**: Auto-reconnects all accounts on disconnect.
- **useKeyboardShortcuts**: Global keyboard shortcut registration.

### Module Structure
```
src/
├── app/           App.tsx, router setup
├── components/    Sidebar, TopBar, Avatar, RightPanel, ErrorBoundary
├── hooks/         useTypingIndicator, useMAM, useXmppReconnect, useKeyboardShortcuts
├── layouts/       MainLayout (3-panel shell)
├── modules/
│   ├── chat/      ConversationList, MessageView
│   ├── roster/    RosterPanel (contacts)
│   ├── group/     GroupPanel (MUC rooms)
│   ├── media/     FileUpload, ImagePreview, FileCard
│   ├── search/    GlobalSearch
│   └── notification/ NotificationPanel
├── pages/         LoginPage, ChatPage, SettingsPage, PluginsPage, AdminPage
├── services/      xmppAdapter, xmppBridge, apiSocket, api, localDb
├── stores/        accountStore, chatStore, rosterStore, notificationStore
├── styles/        globals.css (Tailwind + custom classes)
└── utils/         helpers.ts
```

## Backend Architecture

### FastAPI Routers
| Router | Prefix | Purpose |
|--------|--------|---------|
| auth | /auth | Admin JWT login |
| accounts | /accounts | XMPP account config CRUD |
| conversations | /conversations | Conversation index |
| contacts | /contacts | Contact sync/block |
| messages | /messages | Message indexing + search |
| attachments | /attachments | MinIO file upload |
| plugins | /plugins | Plugin enable/disable |
| ai | /ai | Summarize, translate, smart reply |
| admin | /admin | System status, audit logs |
| websocket | /ws/{id} | Real-time push |

### Database Models
- `accounts` + `account_preferences`
- `contacts`
- `conversations`
- `messages` + `attachments`
- `plugins` + `plugin_settings`
- `ai_jobs`
- `audit_logs`

### Services
- **audit.py**: Write audit log entries
- **storage.py**: MinIO helpers (upload, presign, delete)

## XMPP Protocol Coverage

| Feature | XEP | Status |
|---------|-----|--------|
| Multi-account | — | ✅ |
| MUC group chat | XEP-0045 | ✅ |
| Message Archive | XEP-0313 | ✅ |
| Typing indicators | XEP-0085 | ✅ |
| Delivery receipts | XEP-0184 | ✅ |
| Contact management | RFC 6121 | ✅ |
| Presence | RFC 6121 | ✅ |
| HTTP Upload | XEP-0363 | ✅ (via MinIO) |
| OMEMO encryption | XEP-0384 | 🔜 (future) |
| Push notifications | XEP-0357 | 🔜 (future) |

## Plugin System

Plugins implement the `Plugin` interface from `packages/plugin-sdk/src/index.ts`:

```typescript
interface Plugin {
  manifest: PluginManifest;
  init(ctx: PluginContext): void | Promise<void>;
  destroy?(): void;
  render?(slot: PluginSlot, props: unknown): unknown;
}
```

Available slots: `message.render.before`, `message.render.after`, `chat.toolbar`,
`conversation.sidebar`, `settings.panel`, `command.palette`, `account.menu`,
`global.search.extension`

## Deployment

See `docker-compose.yml` for production and `docker-compose.dev.yml` for development.
Use `make setup` for first-time deployment and `make dev` for local development.
