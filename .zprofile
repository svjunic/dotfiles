#!/bin/zsh

[[ -o interactive ]] || return

echo 'include .zprofile'

export PATH="$PATH:/opt/homebrew/bin"
