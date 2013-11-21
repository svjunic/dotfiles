#!/bin/sh

VIM_HOME=$HOME/.vim
VIM_COLORS=$HOME/.vim/colors
VIM_BUNDLE=$HOME/.vim/bundle
MACVIM_RESOURCES_VIM=/Applications/MacVim.app/Contents/Resources/vim

if [ ! -d ${MACVIM_RESOURCES_VIM} ]
then
	echo 'MacVim is not installed.'
	exit
fi


if [ ! -d ${VIM_HOME} ]
then
        mkdir ${VIM_HOME}
fi

if [ ! -d ${VIM_COLORS} ]
then
        mkdir ${VIM_COLORS}
fi

if [ ! -d ${VIM_BUNDLE} ]
then
        mkdir ${VIM_BUNDLE}
fi



echo "copy .vimrc ~/"
cp .vimrc ~/

echo "copy .gvimrc ~/"
cp .gvimrc ~/

echo "copy ./colors ~/.vim"
cp -a ./colors ~/.vim

echo "git clone neobundle"
git clone https://github.com/Shougo/neobundle.vim.git $VIM_BUNDLE/neobundle.vim
