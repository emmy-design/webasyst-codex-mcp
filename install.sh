#!/bin/bash

set -e

echo "Installing Webasyst Codex MCP Server..."

if ! command -v node &> /dev/null; then
    echo "Error: Node.js 18+ is required."
    echo "Download: https://nodejs.org/"
    exit 1
fi

NODE_MAJOR=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_MAJOR" -lt 18 ]; then
    echo "Error: Node.js 18+ is required. Current version: $(node --version)"
    exit 1
fi

if [ ! -f "package.json" ] || [ ! -f "index.js" ]; then
    echo "Error: run this script from the webasyst-codex-mcp directory."
    exit 1
fi

npm install
chmod +x index.js

echo ""
echo "Installed."
echo ""
echo "Codex config example:"
echo ""
echo "[mcp_servers.webasyst]"
echo "command = \"node\""
echo "args = [\"$(pwd)/index.js\"]"
echo "env = { WEBASYST_ROOT = \"/path/to/webasyst/root\" }"
echo ""
echo "Then restart Codex."
