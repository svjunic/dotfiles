#!/bin/zsh

[[ -o interactive ]] || return

echo 'include .zprofile'

eval "$(/opt/homebrew/bin/brew shellenv)"
