#!/bin/sh

socket=$1
session=$2
window=$3
direction=$4

case $direction in
    left|right) ;;
    *) exit 2 ;;
esac

tmux_server() {
    tmux -S "$socket" "$@"
}

lock="dotfiles-reorder-window-$session"
tmux_server wait-for -L "$lock" || exit 1
trap 'tmux_server wait-for -U "$lock"' EXIT
trap 'exit 1' HUP INT TERM

windows=$(tmux_server list-windows -t "$session" -F '#{window_id}') || exit 1
set -- $windows
[ "$#" -gt 1 ] || exit 0

# Grouped sessions share window positions, so a local reorder is impossible.
group_size=$(tmux_server display-message -p -t "$session:" '#{session_group_size}') || exit 1
if [ "${group_size:-0}" -gt 1 ]; then
    tmux_server display-message -t "$session:" 'Cannot reorder windows shared by a session group'
    exit 0
fi

# Read the window IDs in the direction of travel.
if [ "$direction" = left ]; then
    reversed=
    for candidate do
        reversed="$candidate $reversed"
    done
    set -- $reversed
fi

crossed=
while [ "$#" -gt 0 ] && [ "$1" != "$window" ]; do
    crossed="$1 $crossed"
    shift
done
[ "$#" -gt 0 ] || exit 0

if [ "$#" -gt 1 ]; then
    targets=$2
else
    # To wrap, carry the selected window back across every other window.
    targets=$crossed
fi

# Adjacent swaps reuse the existing index slots. Submit them together with
# selection by ID so the server can apply the reorder in one command sequence.
set --
for candidate in $targets; do
    set -- "$@" swap-window -d -s "$session:$window" -t "$session:$candidate" ';'
done
tmux_server "$@" select-window -t "$session:$window"
