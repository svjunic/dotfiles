#!/usr/bin/env zsh

set -eu

ROOT_DIR="$(cd "$(dirname "$0")" && pwd -P)"

case "$(uname -s)" in
  Darwin)
    bash "$ROOT_DIR/install/mac.sh"
    ;;
  Linux)
    if [[ -n "${SSH_CONNECTION:-}" || -n "${SSH_TTY:-}" ]]; then
      bash "$ROOT_DIR/install/linux-ssh.sh"
    else
      echo "Linux detected. Running linux-ssh setup (SSH env not detected)."
      bash "$ROOT_DIR/install/linux-ssh.sh"
    fi
    ;;
  *)
    echo "Unsupported platform: $(uname -s)"
    exit 1
    ;;
esac
