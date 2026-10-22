#!/usr/bin/env bash

# backup_and_link と ROOT_DIR を定義したインストーラーから読み込む。
setup_worktrunk() {
  local main_tool
  local config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/worktrunk"

  while true; do
    printf 'メインで使うツールを選択してください [1: Codex / 2: Claude]: '
    if ! read -r main_tool; then
      echo 'ツールを選択できませんでした。対話環境で再実行してください。' >&2
      return 1
    fi

    case "$main_tool" in
      1|codex|Codex) main_tool=codex; break ;;
      2|claude|Claude) main_tool=claude; break ;;
      *) echo '1 (Codex) または 2 (Claude) を入力してください。' ;;
    esac
  done

  mkdir -p "$config_dir"
  backup_and_link "$ROOT_DIR/worktrunk/config.$main_tool.toml" "$config_dir/config.toml"
}
