#!/bin/bash

function install_npm() {
    echo '1. npm install ---------------'

    # TypeScript/JavaScript
    npm install -g typescript typescript-language-server

    # tailwindcss
    npm install -g @tailwindcss/language-server

    # Vue
    npm install -g @volar/vue-language-server

    # Astro
    npm install -g @astrojs/language-server

    # HTML/CSS/JSON
    npm install -g vscode-langservers-extracted

    # PHP
    npm install -g intelephense

    # prettier
    npm install -g prettier

    # eslint
    npm install -g eslint
}

function install_brew() {
    echo '2. brew install ---------------'

    # telescope用のフォント
    brew tap homebrew/cask-fonts
    brew install font-hack-nerd-font

    # nvim-treesitter
    brew install gcc
}

case "$1" in
    "npm")
        install_npm
        ;;
    "brew")
        install_brew
        ;;
    "all")
        install_npm
        install_brew
        ;;
    *)
        echo "Usage: $0 [npm|brew|all]"
        exit 1
        ;;
esac
