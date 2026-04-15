# Conjiweb 鈥?Plugin SDK Guide

## Overview

Plugins extend the client with new UI, message processing, commands, and backend integrations.

## Creating a Plugin

### 1. Create plugin folder

```
plugins/my-plugin/
鈹溾攢鈹€ index.ts        Main plugin file
鈹溾攢鈹€ package.json    (optional, for npm deps)
鈹斺攢鈹€ README.md
```

### 2. Implement the Plugin interface

```typescript
import { Plugin, registerPlugin, PluginContext } from "../../packages/plugin-sdk/src/index";

const myPlugin: Plugin = {
  manifest: {
    id: "my-plugin",
    name: "My Plugin",
    version: "1.0.0",
    description: "Does something cool.",
    author: "Your Name",
    permissions: ["messages.read", "api.custom"],
    slots: ["chat.toolbar", "message.render.after"],
  },

  async init(ctx: PluginContext) {
    // Called once when plugin is enabled
    console.log("[my-plugin] Initialized");

    // Listen to events
    ctx.onEvent("message.received", (data) => {
      console.log("New message:", data);
    });

    // Load config
    const config = await ctx.getConfig();
    console.log("Config:", config);
  },

  destroy() {
    // Called when plugin is disabled
    console.log("[my-plugin] Destroyed");
  },

  render(slot, props) {
    // Return UI descriptor for the given slot
    if (slot === "chat.toolbar") {
      return {
        type: "button",
        label: "My Action",
        icon: "Star",
        onClick: async () => {
          ctx.notify("Hello from my plugin!", "success");
        },
      };
    }
    return null;
  },
};

registerPlugin(myPlugin);
export default myPlugin;
```

---

## PluginContext API

```typescript
interface PluginContext {
  pluginId: string;

  // HTTP calls to the FastAPI backend
  callApi(path: string, options?: RequestInit): Promise<unknown>;

  // Current conversation
  getCurrentConversationId(): string | null;

  // Persistent config (stored in backend DB)
  getConfig(): Promise<Record<string, unknown>>;
  saveConfig(config: Record<string, unknown>): Promise<void>;

  // XMPP event subscription
  onEvent(event: PluginEvent, handler: (data: unknown) => void): () => void;

  // Toast notifications
  notify(message: string, type?: "success" | "error" | "info"): void;
}
```

---

## Available Plugin Events

| Event | Data |
|-------|------|
| `message.received` | `{ accountId, message: XmppMessage }` |
| `message.sent` | `{ accountId, message: XmppMessage }` |
| `conversation.opened` | `{ conversationId, type, peerJid }` |
| `conversation.closed` | `{ conversationId }` |
| `roster.updated` | `{ accountId, contacts }` |
| `presence.updated` | `{ accountId, jid, show, status }` |
| `room.joined` | `{ accountId, roomJid, nickname }` |
| `room.left` | `{ accountId, roomJid }` |

---

## Injection Slots

| Slot | Where it appears |
|------|-----------------|
| `message.render.before` | Above each message bubble |
| `message.render.after` | Below each message bubble |
| `chat.toolbar` | Right side of chat header |
| `conversation.sidebar` | Right panel extra tab |
| `settings.panel` | Settings page new section |
| `command.palette` | `/` slash command list |
| `account.menu` | Account dropdown menu |
| `global.search.extension` | Extra section in search results |

---

## Render Return Format

The `render()` method returns a UI descriptor object:

```typescript
// Button
{ type: "button", label: "Do Thing", icon: "Star", onClick: async () => {} }

// Dropdown menu
{ type: "dropdown", label: "Options", icon: "ChevronDown", items: [
  { label: "Option A", onClick: () => {} },
  { label: "Option B", onClick: () => {} },
]}

// Custom React panel (advanced)
{ type: "panel", component: MyReactComponent, props: {} }
```

---

## Permissions

Declare required permissions in your manifest:

| Permission | Access granted |
|-----------|---------------|
| `messages.read` | Read conversation messages |
| `messages.send` | Send messages via context |
| `contacts.read` | Read roster contacts |
| `api.ai` | Call /ai/* endpoints |
| `api.attachments` | Upload files |
| `api.custom` | Call any backend endpoint |
| `notifications` | Show toast + browser notifications |

---

## Built-in Plugins

| Plugin | ID | Features |
|--------|----|---------|
| AI Summary | `ai-summary` | Summarize conversations, key points |
| Translate | `translate` | Translate messages via AI endpoint |
| Quick Reply | `quick-reply` | Pre-configured reply templates |

---

## Enabling Plugins

1. Go to **Admin 鈫?Plugins** in the web interface
2. Toggle the plugin switch to enable
3. Plugin `init()` is called immediately

Or via API:
```bash
curl -X POST http://localhost:8000/plugins/my-plugin/enable \
  -H "Authorization: Bearer <admin_token>"
```
