#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/install_deps.sh [brew|apt|all]

  brew : Install Vim-related dependencies for macOS
  apt  : Install Vim-related dependencies for Linux (source build prerequisites)
  all  : Run OS-appropriate dependency installer
USAGE
}

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "ERROR: required command not found: $1" >&2
    exit 1
  fi
}

install_brew() {
  need_cmd brew
  brew install git curl vim
}

install_apt() {
  need_cmd sudo
  need_cmd apt-get
  sudo apt-get update
  sudo apt-get build-dep -y vim
  sudo apt-get install -y git curl gettext libncurses5-dev libacl1-dev libgpm-dev
  sudo apt-get install -y libxmu-dev libgnomeui-dev libxpm-dev
  sudo apt-get install -y libperl-dev python-dev python3-dev ruby-dev
  sudo apt-get install -y lua5.2 liblua5.2-dev
  sudo apt-get install -y luajit libluajit-5.1
  sudo apt-get install -y autoconf automake cproto
}

case "${1:-}" in
  brew)
    install_brew
    ;;
  apt)
    install_apt
    ;;
  all)
    if [ "$(uname -s)" = "Darwin" ]; then
      install_brew
    elif [ "$(uname -s)" = "Linux" ]; then
      install_apt
    else
      echo "Unsupported platform: $(uname -s)"
      exit 1
    fi
    ;;
  *)
    usage
    exit 1
    ;;
esac
