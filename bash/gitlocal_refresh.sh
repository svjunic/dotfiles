#!/bin/sh

git checkout master
git branch -d local
git pull
git checkout -b local
