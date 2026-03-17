#!/bin/bash
set -e

echo "🚀 Claude 2x Status Bar Installer"
echo "----------------------------------"

# 1. Homebrew check
if ! command -v brew &>/dev/null; then
  echo "❌ Homebrew not found. Please install it first: https://brew.sh"
  exit 1
fi

# 2. SwiftBar
if ! brew list --cask swiftbar &>/dev/null; then
  echo "📦 Installing SwiftBar..."
  brew install --cask swiftbar
else
  echo "✅ SwiftBar already installed"
fi

# 3. jq
if ! command -v jq &>/dev/null; then
  echo "📦 Installing jq..."
  brew install jq
else
  echo "✅ jq already installed"
fi

# 4. Plugin folder
PLUGIN_DIR="$HOME/SwiftBar"
mkdir -p "$PLUGIN_DIR"

# 5. Write plugin script
SCRIPT="$PLUGIN_DIR/claude2x.1m.sh"

cat > "$SCRIPT" << 'EOF'
#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

DATA=$(curl -s --max-time 5 "https://isclaude2x.com/json" 2>/dev/null)

if [ -z "$DATA" ] || ! echo "$DATA" | jq -e . &>/dev/null; then
  echo "⚠️ Claude | color=orange"
  echo "---"
  echo "API not reachable"
  echo "Refresh | refresh=true"
  echo "isclaude2x.com | href=https://isclaude2x.com"
  exit 0
fi

IS_2X=$(echo "$DATA" | jq -r '.is2x')
EXPIRES=$(echo "$DATA" | jq -r '."2xWindowExpiresIn"')
PERIOD=$(echo "$DATA" | jq -r '.promoPeriod')

if [ "$IS_2X" = "true" ]; then
  echo "⚡️ Claude 2x | color=green"
  echo "---"
  echo "Active for: $EXPIRES"
else
  echo "Claude 1x | color=gray"
  echo "---"
  echo "Promo period: $PERIOD"
fi

echo "Refresh | refresh=true"
echo "isclaude2x.com | href=https://isclaude2x.com"
EOF

chmod +x "$SCRIPT"
echo "✅ Plugin created: $SCRIPT"

# 6. Open SwiftBar
echo ""
echo "✅ Done! Opening SwiftBar..."
echo "👉 When prompted, set the plugin folder to: $PLUGIN_DIR"
echo ""
open -a SwiftBar 2>/dev/null || echo "Please open SwiftBar manually and set the plugin folder to: $PLUGIN_DIR"