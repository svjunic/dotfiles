#!/bin/bash

brew install --HEAD universal-ctags/universal-ctags/universal-ctags

pwd=`pwd -P`

ln -s ${pwd}/.ctags.d ~/.ctags.d
