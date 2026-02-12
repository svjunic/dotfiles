#!/usr/bin/env sh

alias ls="ls -G"
alias ll="ls -lG"
alias la="ls -laG"
alias openf='sh ~/bash/openf.sh'

# Auto-attach tmux only on interactive iTerm sessions.
if [ -n "${ITERM_SESSION_ID:-}" ] && [ -z "${TMUX:-}" ] && [ -n "${PS1:-}" ]; then
  tmux a -d || tmux
fi
