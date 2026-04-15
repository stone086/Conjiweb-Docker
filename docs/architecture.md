# Conjiweb 鈥?Architecture Documentation

## Overview

Conjiweb is a seven-layer full-stack XMPP web client platform.

```
鈹屸攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?鈹? Layer 1: Presentation                              鈹?鈹? React 18 + TypeScript + Tailwind CSS + Vite        鈹?鈹溾攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?鈹? Layer 2: Application State                         鈹?鈹? Zustand + TanStack Query + IndexedDB (Dexie.js)    鈹?鈹溾攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?鈹? Layer 3: XMPP Adapter                              鈹?鈹? XmppClient (Strophe.js wrapper) + xmppBridge       鈹?鈹溾攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?鈹? Layer 4: Business API                              鈹?鈹? FastAPI + SQLAlchemy + Alembic + WebSocket         鈹?鈹溾攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?鈹? Layer 5: Data                                      鈹?鈹? PostgreSQL (primary) + Redis (cache) + IndexedDB   鈹?鈹溾攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?鈹? Layer 6: Object Storage                            鈹?鈹? MinIO (S3-compatible file storage)                 鈹?鈹溾攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?鈹? Layer 7: XMPP Server                               鈹?鈹? Prosody (XMPP, MUC, MAM, HTTP Upload, WebSocket)  鈹?鈹斺攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?```

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
鈹溾攢鈹€ app/           App.tsx, router setup
鈹溾攢鈹€ components/    Sidebar, TopBar, Avatar, RightPanel, ErrorBoundary
鈹溾攢鈹€ hooks/         useTypingIndicator, useMAM, useXmppReconnect, useKeyboardShortcuts
鈹溾攢鈹€ layouts/       MainLayout (3-panel shell)
鈹溾攢鈹€ modules/
鈹?  鈹溾攢鈹€ chat/      ConversationList, MessageView
鈹?  鈹溾攢鈹€ roster/    RosterPanel (contacts)
鈹?  鈹溾攢鈹€ group/     GroupPanel (MUC rooms)
鈹?  鈹溾攢鈹€ media/     FileUpload, ImagePreview, FileCard
鈹?  鈹溾攢鈹€ search/    GlobalSearch
鈹?  鈹斺攢鈹€ notification/ NotificationPanel
鈹溾攢鈹€ pages/         LoginPage, ChatPage, SettingsPage, PluginsPage, AdminPage
鈹溾攢鈹€ services/      xmppAdapter, xmppBridge, apiSocket, api, localDb
鈹溾攢鈹€ stores/        accountStore, chatStore, rosterStore, notificationStore
鈹溾攢鈹€ styles/        globals.css (Tailwind + custom classes)
鈹斺攢鈹€ utils/         helpers.ts
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
| Multi-account | 鈥?| 鉁?|
| MUC group chat | XEP-0045 | 鉁?|
| Message Archive | XEP-0313 | 鉁?|
| Typing indicators | XEP-0085 | 鉁?|
| Delivery receipts | XEP-0184 | 鉁?|
| Contact management | RFC 6121 | 鉁?|
| Presence | RFC 6121 | 鉁?|
| HTTP Upload | XEP-0363 | 鉁?(via MinIO) |
| OMEMO encryption | XEP-0384 | 馃敎 (future) |
| Push notifications | XEP-0357 | 馃敎 (future) |

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
