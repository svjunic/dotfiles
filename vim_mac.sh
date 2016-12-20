#!/bin/sh

VIM_HOME=$HOME/.vim
VIM_BUNDLE=$HOME/.vim/bundle

if [ ! -d ${MACVIM_RESOURCES_VIM} ]
then
  echo 'MacVim is not installed.'
  exit
fi


## .tern-projectの設定ファイル移動
cp vim/.tern-project ~/
cp vim/.eslintrc ~/
cp vim/.agignore ~/


if [ ! -d ${VIM_HOME} ]
then
  mkdir ${VIM_HOME}
fi

if [ ! -d ${VIM_BUNDLE} ]
then
  mkdir ${VIM_BUNDLE}
fi

echo "copy .vimrc ~/"
cp vim/.vimrc ~/

echo "copy .gvimrc ~/"
cp vim/.gvimrc ~/

echo "git clone neobundle"
git clone git://github.com/Shougo/neobundle.vim.git $VIM_BUNDLE/neobundle.vim
