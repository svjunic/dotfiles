#!/usr/bin/env bash

set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
  echo "This script is for macOS only."
  exit 1
fi

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

# mkdir -p "$HOME/.config/nvim"
ln -s "$HOME/virtual/github/dotfiles/neovim" "$HOME/.config/nvim"


echo "neovim setup for mac completed."

