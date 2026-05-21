#!/usr/bin/env bash

set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
  echo "This script is for macOS only."
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"

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

# Neovim本体
if command -v brew >/dev/null 2>&1; then
  brew install neovim || true
else
  echo "brew not found. Skip brew install neovim."
fi

# Python provider
if command -v pip3 >/dev/null 2>&1; then
  pip3 install --upgrade neovim
else
  echo "pip3 not found. Skip pip3 install neovim."
fi

mkdir -p "$HOME/.config"
backup_and_link "$ROOT_DIR/neovim" "$HOME/.config/nvim"

echo "neovim setup for mac completed."
