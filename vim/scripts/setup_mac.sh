#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"
VIM_HOME="$HOME/.vim"
VIM_CACHE="$HOME/.cache"
VIM_BUNDLE="${VIM_BUNDLE:-$HOME/.vim/bundle}"

if [ "$(uname -s)" != "Darwin" ]; then
  echo "This script is for macOS only."
  exit 1
fi

mkdir -p "$VIM_HOME" "$VIM_CACHE" "$VIM_BUNDLE"

# Vim本体
if command -v brew >/dev/null 2>&1; then
  brew install vim || true
else
  echo "brew not found. Skip brew install vim."
fi

# Vim設定
ln -sfn "$ROOT_DIR/vim/.vimrc" "$HOME/.vimrc"
ln -sfn "$ROOT_DIR/vim/coc-settings.json" "$HOME/.vim/coc-settings.json"
ln -sfn "$ROOT_DIR/vim/vim" "$HOME/.vim/vim"
ln -sfn "$ROOT_DIR/vim/toml" "$HOME/.vim/toml"

# dein
if command -v curl >/dev/null 2>&1; then
  tmp_installer="$(mktemp)"
  curl -fsSL https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > "$tmp_installer"
  sh "$tmp_installer" "$HOME/.cache/dein"
  rm -f "$tmp_installer"
else
  echo "curl not found. Skip dein install."
fi

echo "vim setup for mac completed."
