#!/usr/bin/env zsh

set -eu

tmux_ai_grid() {
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

  tmux resize-pane -t "$left" -x 160
}

tmux_coding_grid() {
  if ! command -v tmux >/dev/null 2>&1; then
    echo "tmux command not found." >&2
    return 1
  fi
  if [ -z "${TMUX:-}" ]; then
    echo "Not inside a tmux session." >&2
    return 1
  fi

  local f_cwd f_id c left
  f_cwd='{pane_current_path}'
  f_id='{pane_id}'

  c="$(tmux display-message -p -F "#$f_cwd")"
  left="$(tmux display-message -p -F "#$f_id")"

  # 右ペインを 25% で作ることで、左を広め（約 65%）にする
  tmux split-window -h -p 25 -c "$c"
  tmux select-pane -t "$left"
}

case "${1:-}" in
  ai_grid|left_tall_right_grid)
    tmux_ai_grid
    ;;
  coding_grid)
    tmux_coding_grid
    ;;
  "")
    tmux_ai_grid
    ;;
  *)
    echo "Usage: $0 [ai_grid|coding_grid]" >&2
    exit 1
    ;;
esac
