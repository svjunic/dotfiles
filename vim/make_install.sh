#!/bin/bash

# 参考:http://vim-jp.org/docs/build_linux.html

sudo apt-get build-dep vim
sudo apt-get install git gettext libncurses5-dev libacl1-dev libgpm-dev
sudo apt-get install libxmu-dev libgnomeui-dev libxpm-dev
sudo apt-get install libperl-dev python-dev python3-dev ruby-dev
sudo apt-get install lua5.2 liblua5.2-dev
sudo apt-get install luajit libluajit-5.1
sudo apt-get install autoconf automake cproto
git clone https://github.com/vim/vim.git

cd vim
git fetch
git merge
git pull

# ./configure --with-features=huge --enable-gui=gnome2 --enable-fail-if-missing
./configure --with-features=huge --enable-gui=gnome2 --enable-fail-if-missing --prefix=/usr/local/lib


# GTK2 GUI版
#./configure --with-features=huge --enable-gui=gnome2 --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-luainterp --enable-fail-if-missing
#./configure --with-features=huge --enable-gui=gnome2 --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-luainterp --with-luajit --enable-fail-if-missing
make
# makeし直し
#make reconfig

sudo make install


