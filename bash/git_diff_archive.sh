#!/bin/bash

function git_diff_archive()
{
  local diff=""
  local h="HEAD"
  if [ $# -eq 1 ]; then
    #if expr "$1" : '[0-9]*' > /dev/null ; then
    #  diff="HEAD HEAD~${1}"
    #else
    #diff="HEAD ${1}"
    diff="${1}"
    #fi
  elif [ $# -eq 2 ]; then
    diff="${1} ${2}"
    h=$1
  fi
  if [ "$diff" != "" ]; then
    diff="git diff --diff-filter=d --name-only ${diff}"
  fi
  echo $diff
  git archive --format=zip --prefix=root/ $h `eval $diff` -o archive.zip
}
