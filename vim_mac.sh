#!/bin/sh

VIM_HOME=$HOME/.vim

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

if [ ! -d ${VIM_BUNDLE} ]
then
  mkdir ${VIM_BUNDLE}
fi

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
