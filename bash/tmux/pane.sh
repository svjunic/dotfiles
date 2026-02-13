#!/usr/bin/env zsh

set -eu

tmux_left_tall_right_grid() {
  if ! command -v tmux >/dev/null 2>&1; then
    echo "tmux command not found." >&2
    return 1
  fi
  if [ -z "${TMUX:-}" ]; then
    echo "Not inside a tmux session." >&2
    return 1
  fi

  local f_cwd f_id c left right bottom
  f_cwd='{pane_current_path}'
  f_id='{pane_id}'

  c="$(tmux display-message -p -F "#$f_cwd")"
  left="$(tmux display-message -p -F "#$f_id")"

  right="$(tmux split-window -h -c "$c" -P -F "#$f_id")"
  bottom="$(tmux split-window -v -t "$right" -c "$c" -P -F "#$f_id")"

  tmux split-window -h -t "$right" -c "$c"
  tmux split-window -h -t "$bottom" -c "$c"

  tmux select-pane -t "$left"
}

case "${1:-}" in
  left_tall_right_grid)
    tmux_left_tall_right_grid
    ;;
  "")
    tmux_left_tall_right_grid
    ;;
  *)
    echo "Usage: $0 [left_tall_right_grid]" >&2
    exit 1
    ;;
esac
