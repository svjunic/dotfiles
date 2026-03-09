#!/usr/bin/env bash

set -euo pipefail

# git global config
git config --global color.ui auto
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.br branch
git config --global alias.hist 'log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
git config --global alias.st  'status --branch --short'
git config --global alias.sl  'log --all --branches --decorate --graph --oneline'
git config --global alias.log 'log --all --branches --graph'
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.side-by-side true
