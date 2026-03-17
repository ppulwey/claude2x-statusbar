# Claude 2x Status Bar

A lightweight macOS status bar plugin that shows whether the [Claude 2x promotion](https://isclaude2x.com) is currently active. Updates every minute.

![Status Bar Preview](https://img.shields.io/badge/Claude-2x%20Active-green) ![Platform](https://img.shields.io/badge/platform-macOS-lightgrey) ![License](https://img.shields.io/badge/license-MIT-blue)

## What it looks like

| State | Status Bar |
|-------|-----------|
| 2x active | `⚡️ Claude 2x` (green) + remaining time |
| 2x inactive | `Claude 1x` (gray) + promo period |

## Requirements

- macOS
- [Homebrew](https://brew.sh)

## Install
```bash
curl -fsSL https://raw.githubusercontent.com/ppulwey/claude2x-statusbar/main/install.sh | bash
```

After installation, open SwiftBar and set the plugin folder to `~/SwiftBar` when prompted.

## How it works

The plugin polls the [isclaude2x.com](https://isclaude2x.com) API every minute:
```
GET https://isclaude2x.com/json
```

All credits for the API go to [isclaude2x.com](https://isclaude2x.com).

## What gets installed

- [SwiftBar](https://swiftbar.app) — runs shell scripts as status bar plugins
- [jq](https://jqlang.github.io/jq/) — JSON parsing in bash
- `~/SwiftBar/claude2x.1m.sh` — the plugin script

## Uninstall
```bash
rm ~/SwiftBar/claude2x.1m.sh
```

To fully remove SwiftBar and jq:
```bash
brew uninstall --cask swiftbar
brew uninstall jq
```

## License

MIT