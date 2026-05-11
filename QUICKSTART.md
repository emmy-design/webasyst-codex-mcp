# Quickstart: Webasyst Codex MCP

## Install

```bash
cd /path/to/webasyst-codex-mcp
npm install
node --check index.js
```

Optional global local command:

```bash
npm link
webasyst-codex-mcp
```

## Configure Codex

Add the server to `~/.codex/config.toml`:

```toml
[mcp_servers.webasyst]
command = "node"
args = ["/path/to/webasyst-codex-mcp/index.js"]
env = { WEBASYST_ROOT = "/path/to/webasyst/root" }
```

Restart Codex after changing MCP configuration.

## UI Workflow

For Webasyst backend UI tasks, use this order:

1. Call `get_webasyst_ui_context` before editing templates.
2. Reuse component examples from `wa-apps/ui/templates/actions/component`.
3. Use Webasyst UI 2.0 classes from `wa-content/css/wa/wa-2.0.css`.
4. Prefer `create_webasyst_ui_component` for new snippets.
5. Run `audit_webasyst_ui_surface` after edits.

## Useful Prompts

- "Show Webasyst UI context for backend table and button components."
- "Create a Webasyst UI settings form snippet for this app."
- "Audit this backend template for Webasyst UI 2.0 consistency."
- "Create a Shop-Script plugin scaffold and use Webasyst UI 2.0 for its settings screen."
