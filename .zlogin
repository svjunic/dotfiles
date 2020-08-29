#!/bin/zsh


echo 'include .zlogin'

test -r ~/.zbashrc && source ~/.zbashrc

if [ -f ~/.zbashrc_local ]; then
  test -r ~/.zbashrc_local && source ~/.zbashrc_local
fi
