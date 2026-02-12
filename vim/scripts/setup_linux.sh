#!/usr/bin/env bash

set -euo pipefail

if [ "$(uname -s)" != "Linux" ]; then
  echo "This script is for Linux only."
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"
VIM_HOME="$HOME/.vim"
VIM_BUNDLE="$HOME/.vim/bundle"

echo "Build and install Vim from source."

if [ ! -d "$HOME/vim/.git" ]; then
  git clone https://github.com/vim/vim.git "$HOME/vim"
fi

cd "$HOME/vim"
git fetch
git pull --ff-only
./configure --with-features=huge --enable-gui=gnome2 --enable-fail-if-missing --prefix=/usr/local/lib
make
sudo make install

mkdir -p "$VIM_HOME" "$VIM_BUNDLE"
cp "$ROOT_DIR/vim/.vimrc" "$HOME/.vimrc"

if [ ! -d "$VIM_BUNDLE/neobundle.vim/.git" ]; then
  git clone https://github.com/Shougo/neobundle.vim.git "$VIM_BUNDLE/neobundle.vim"
fi

echo "vim setup for linux completed."
