#!/bin/sh

VIM_HOME=$HOME/.vim
VIM_BUNDLE=$HOME/.vim/bundle

if [ ! -d ${VIM_HOME} ]
then
  mkdir ${VIM_HOME}
fi

if [ ! -d ${VIM_BUNDLE} ]
then
  mkdir ${VIM_BUNDLE}
fi

cat vimrc_local.vim .vimrc > .vimrc.linux

echo "copy .vimrc ~/"
cp .vimrc.linux ~/.vimrc

echo "git clone neobundle"
git clone git://github.com/Shougo/neobundle.vim.git $VIM_BUNDLE/neobundle.vim
