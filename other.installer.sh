#!/bin/bash

brew upgrade

## ddu.nvim依存
curl -fsSL https://deno.land/install.sh | sh

## ddu.nvimのgrepで使用
brew install ripgrep
