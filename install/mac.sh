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

echo "mac setup completed."
