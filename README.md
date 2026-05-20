# Webasyst Codex MCP

> **For Codex.** This repository is the Codex-first Webasyst MCP server, optimized for Codex rmcp client compatibility, automatic Webasyst UI 2.0 context, and post-edit UI audits.
>
> **Unofficial project.** This MCP server is community-maintained and is not affiliated with, endorsed by, or sponsored by Webasyst.
>
> If you use Claude Desktop or Cursor, see the Claude/Cursor-oriented server: [emmy-design/webasyst-mcp](https://github.com/emmy-design/webasyst-mcp).

Codex-first MCP server for Webasyst development. It exposes tools for inspecting and generating Webasyst apps, plugins, widgets, themes, actions, models, localization files, release bundles, DevOps snippets, and Webasyst UI 2.0 surfaces.

This package is intentionally separate from `webasyst-mcp`: it keeps the broad Webasyst toolset, but adds Codex-compatible handshake behavior and a strict backend UI workflow around `wa-apps/ui`, `wa-2.0.css`, and Webasyst JS helpers.

## Why This Exists

Codex may probe `resources/list` and `prompts/list` on tool-only MCP servers. This server returns empty lists for those requests so startup remains deterministic.

For Webasyst backend UI work, the server also provides dedicated context and audit tools so agents do not need to be reminded in every prompt to use Webasyst UI 2.0 patterns.

## Install

```bash
git clone https://github.com/emmy-design/webasyst-codex-mcp.git
cd webasyst-codex-mcp
npm install
node index.js
```

Optional global local link:

```bash
npm link
webasyst-codex-mcp
```

## Codex Configuration

Add the server to `~/.codex/config.toml`:

```toml
[mcp_servers.webasyst]
command = "node"
args = ["/path/to/webasyst-codex-mcp/index.js"]
env = { WEBASYST_ROOT = "/path/to/webasyst/root" }
```

`WEBASYST_ROOT` is optional but recommended. If it is omitted, the server searches upward from its current working directory until it finds `index.php` and `wa-system`.

## Codex UI Workflow

For any task that creates or edits Webasyst backend UI for apps, plugins, widgets, settings pages, dialogs, tables, forms, or feature screens:

1. Call `get_webasyst_ui_context`.
2. Reuse real patterns from `wa-apps/ui/templates/actions/component/`.
3. Use classes from `wa-content/css/wa/wa-2.0.css` before adding custom CSS.
4. Use Webasyst JS helpers from `wa-content/js/jquery-wa/wa.js` and `wa-apps/ui/js/`.
5. After UI changes, call `audit_webasyst_ui_surface` on changed backend templates.

## Codex-Specific Tools

- `get_webasyst_ui_context` - returns the Webasyst UI 2.0 contract, key paths, class guidance, and optional source excerpts.
- `list_webasyst_ui_components` - lists UI component examples and JS helpers available in the target Webasyst project.
- `get_webasyst_ui_component` - reads a real component source file such as `button`, `fields`, `table`, `dialog`, or `dropdown`.
- `create_webasyst_ui_component` - creates reusable snippets in `target_path/templates/components/`; supports `_w()` for apps and `_wp()` for plugins.
- `audit_webasyst_ui_surface` - checks a template for Webasyst UI 2.0 classes, `{$wa->css()}`, `wa.js`, table/form patterns, and non-Webasyst design-system classes.

## Broader Webasyst Tools

The server also includes upstream Webasyst tooling for:

- app, plugin, widget, theme, action, and model scaffolding;
- Site and Shop-Script helpers;
- UI component generation and UI usage validation;
- localization template generation and `.mo` compilation;
- release bundle preparation;
- nginx and `.htaccess` snippets;
- color scheme and responsive layout generation.

## Public Safety

Do not commit local credentials or project secrets. In particular, never include:

- service-account JSON files;
- `*-service-account.json`;
- private keys;
- API tokens;
- `node_modules/`;
- local Webasyst data files.

Run before publishing:

```bash
rg -n --hidden --glob '!node_modules/**' --glob '!.git/**' "PRIVATE KEY|BEGIN|apiKey|secret|token|password|client_email|/Users/|/home/" .
npm pack --dry-run
```

## Development Checks

```bash
npm install
node --check index.js
npm test
```

Smoke-test the MCP server through a stdio client and verify:

- `listTools` includes the Codex-specific UI tools;
- `get_webasyst_ui_context` resolves the configured Webasyst root;
- `get_webasyst_ui_component` can read `wa-apps/ui/templates/actions/component/button.html`;
- generated UI snippets pass `audit_webasyst_ui_surface`.
