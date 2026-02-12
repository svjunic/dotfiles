#!/bin/bash

function install_npm() {
    echo '1. npm install ---------------'

    ## ddu.nvim依存
    curl -fsSL https://deno.land/install.sh | sh

    # TypeScript/JavaScript
    npm install -g typescript
    npm install -g @vtsls/language-server

    # tailwindcss
    npm install -g @tailwindcss/language-server

    # Vue
    npm install -g @volar/vue-language-server

    # Astro
    npm install -g @astrojs/language-server

    # yaml
    npm install -g yaml-language-server

    # HTML/CSS/JSON
    npm install -g vscode-langservers-extracted

    ## HTML/CSS/JSON
    #npm install -g bash-language-server

    # PHP
    npm install -g intelephense

    # prettier
    npm install -g prettier
    npm install -g prettier-plugin-astro
    npm install -g @prettier/plugin-lua

    # eslint
    npm install -g eslint
}

function install_brew() {
    echo '2. brew install ---------------'

    # telescope用のフォント
    brew tap homebrew/cask-fonts
    brew install font-hack-nerd-font

    # nvim-treesitter
    brew install tree-sitter
    brew install tree-sitter-cli
    brew install gcc

    # nvim-tree/fzf-lua用
    brew install fzf
    brew install ripgrep
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
