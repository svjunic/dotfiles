#!/bin/sh

VIM_HOME=$HOME/.vim
VIM_CACHE=$HOME/.cache

if [ ! -d ${MACVIM_RESOURCES_VIM} ]
then
  echo 'MacVim is not installed.'
  exit
fi

#cp vim/.tern-project ~/

if [ ! -d ${VIM_HOME} ]
then
  mkdir ${VIM_HOME}
fi

rm -rf ${VIM_CACHE}
if [ ! -d ${VIM_CACHE} ]
then
  mkdir ${VIM_CACHE}
fi

if [ ! -d ${VIM_BUNDLE} ]
then
  mkdir ${VIM_BUNDLE}
fi

echo "npm install"
npm i -g eslint
npm i -g htmlhint
npm i -g prettier
npm i -g prettier-eslint-cli
#npm i -g prettier/plugin-php

echo "python3.6 install"
brew uninstall --ignore-dependencies python3
brew uninstall --ignore-dependencies vim

brew install python3
brew install vim --with-python3

#pip install --upgrade pip
#pip3 install --upgrade neovim

echo "copy .vimrc ~/"
cp vim/.vimrc ~/

echo "copy .gvimrc ~/"
cp vim/.gvimrc ~/

echo "dein install"
mkdir -p ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein

echo "copy my vimscript"
rsync -r vim/vim/ ~/.vim/vim
