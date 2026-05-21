#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

backup_and_link() {
  local src="$1"
  local dest="$2"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "skip: $dest"
    return
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    local backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dest" "$backup"
    echo "backup: $dest -> $backup"
  fi

  ln -s "$src" "$dest"
  echo "link: $dest -> $src"
}

ensure_brew_package() {
  local package="$1"

  if ! command -v brew >/dev/null 2>&1; then
    echo "brew not found. skip installing $package" >&2
    return 1
  fi

  if brew list "$package" >/dev/null 2>&1; then
    echo "skip brew install: $package"
    return 0
  fi

  brew install "$package"
}

ensure_claude_team_commands() {
  ensure_brew_package tmux || true
  ensure_brew_package terminal-notifier || true
  ensure_brew_package node || true

  if command -v claude >/dev/null 2>&1; then
    echo "skip npm install: @anthropic-ai/claude-code"
    return 0
  fi

  if ! command -v npm >/dev/null 2>&1; then
    echo "npm not found. skip installing @anthropic-ai/claude-code" >&2
    return 1
  fi

  npm install -g @anthropic-ai/claude-code
}

backup_and_link "$ROOT_DIR/.zlogin" "$HOME/.zlogin"
backup_and_link "$ROOT_DIR/.zprofile" "$HOME/.zprofile"
backup_and_link "$ROOT_DIR/.zbashrc" "$HOME/.zbashrc"
backup_and_link "$ROOT_DIR/.zshenv" "$HOME/.zshenv"
backup_and_link "$ROOT_DIR/.eslintrc" "$HOME/.eslintrc"
backup_and_link "$ROOT_DIR/.eslintrc.js" "$HOME/.eslintrc.js"
backup_and_link "$ROOT_DIR/.prettierrc.yaml" "$HOME/.prettierrc.yaml"
backup_and_link "$ROOT_DIR/.gitconfig" "$HOME/.gitconfig"
backup_and_link "$ROOT_DIR/.tmux" "$HOME/.tmux"
backup_and_link "$ROOT_DIR/.tmux.conf" "$HOME/.tmux.conf"

backup_and_link "$ROOT_DIR/bash" "$HOME/bash"
backup_and_link "$ROOT_DIR/zsh" "$HOME/zsh"
backup_and_link "$ROOT_DIR/command" "$HOME/command"
backup_and_link "$ROOT_DIR/shell" "$HOME/shell"

ensure_claude_team_commands

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

bash "$ROOT_DIR/install/common.sh"

echo "mac setup completed."
