#!/bin/bash

echo '1. npm install ---------------'

# TypeScript/JavaScript
npm install -g typescript typescript-language-server

# Vue
npm install -g @volar/vue-language-server

# HTML/CSS/JSON
npm install -g vscode-langservers-extracted

# PHP
npm install -g intelephense

# prettier
npm install -g prettier

# eslint
npm install -g eslint


echo '2. brew install ---------------'

# telecsope用のフォント
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font

# nvim-treesitter
brew install gcc
