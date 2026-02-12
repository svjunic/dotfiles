#!/bin/zsh

[[ -o interactive ]] || return

echo 'include .zprofile'

if [ "$(uname -s)" = "Darwin" ]; then
  export PATH="$PATH:/opt/homebrew/bin"
fi
