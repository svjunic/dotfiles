#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd -P)"

case "$(uname -s)" in
  Darwin)
    bash "$ROOT_DIR/install/mac.sh"
    ;;
  Linux)
    bash "$ROOT_DIR/install/linux-ssh.sh"
    ;;
  *)
    echo "Unsupported platform: $(uname -s)"
    exit 1
    ;;
esac
