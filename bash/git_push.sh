#!/bin/sh

PREFIX_MESSAGE="[dev-js] "

MESSAGE="テストコミット"

if [ $# -ne 1 ]; then
	echo "parameter error. ($#/1)"
	echo "need string to search."
	exit 1
fi

MESSAGE=$1;

git checkout local
git add *
git commit -m "${PREFIX_MESSAGE}${MESSAGE}"
git checkout master
git pull

git merge local
git push
git checkout -
