#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: install.sh [npm|brew|all]

  npm  : Install global npm tools (LSP/formatters used by neovim config)
  brew : Install Homebrew packages used by neovim config (macOS)
  all  : Run both
USAGE
}

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "ERROR: required command not found: $1" >&2
    exit 1
  fi
}

install_npm() {
  echo '1. npm install (global) ---------------'

  need_cmd npm

  # TypeScript/JavaScript (LSP)
  npm install -g typescript
  npm install -g @vtsls/language-server

  # Vue (LSP)
  npm install -g @volar/vue-language-server

  # Astro (LSP)
  npm install -g @astrojs/language-server

  # YAML (LSP)
  npm install -g yaml-language-server

  # HTML/CSS/JSON (LSP)
  npm install -g vscode-langservers-extracted

  # PHP (optional in many repos, kept for parity with vim/install.sh)
  npm install -g intelephense

  # Prettier (formatter)
  npm install -g prettier
  npm install -g prettier-plugin-astro
  npm install -g @prettier/plugin-lua

  # markuplint/stylelint (used by conform.nvim)
  npm install -g markuplint
  npm install -g stylelint

  # eslint (optional; kept for parity)
  npm install -g eslint

  echo 'NOTE: neotest-playwright usually expects project-local Playwright (@playwright/test)'
  echo '      If needed, run: npm i -D @playwright/test && npx playwright install'
}

install_brew() {
  echo '2. brew install ---------------'

  need_cmd brew

  # telescope用のフォント
  brew tap homebrew/cask-fonts >/dev/null 2>&1 || true
  brew install font-hack-nerd-font

  # nvim-treesitter (building parsers uses a C compiler)
  brew install tree-sitter
  brew install tree-sitter-cli
  brew install gcc

  # telescope live_grep
  brew install ripgrep

  # telescope-fzf-native (optional but configured)
  brew install fzf

  # Markdown LSP
  brew install marksman
}

case "${1:-}" in
  npm)
    install_npm
    ;;
  brew)
    install_brew
    ;;
  all)
    install_npm
    install_brew
    ;;
  *)
    usage
    exit 1
    ;;
esac
