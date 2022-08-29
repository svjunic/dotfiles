#!/bin/zsh

echo 'reload'

function git_diff_archive()
{
  local diff=""
  local h="HEAD"

  if [ $# -eq 1 ]; then
    #if expr "$1" : '[0-9]*' > /dev/null ; then
    #  diff="HEAD HEAD~${1}"
    #else
    #diff="HEAD ${1}"
    diff="'${1}'"
    #fi
  elif [ $# -eq 2 ]; then
    diff="'${1}' '${2}'"
    h=$1
  fi

  if [ "$diff" != "" ]; then
    diff="git diff --diff-filter=d --name-only ${diff}"
  fi

  git archive --format=zip --prefix=root/ $h `eval $diff` -o archive.zip
}

function git_diff_archive_date()
{
  local zip ='archive.zip'
  local ArchiveFiles='archive_files.csv'
  local ArchiveTemp='archive_files_temp.csv'
  local ArchiveBase='archive_files_base.csv'
  local ArchiveStatus='archive_files_status.csv'
  local ArchiveSize='archive_files_size.csv'

  if [ "$2" = "" ]; then
      git diff --name-only $1 HEAD | xargs -I {} sh -c 'echo {},"`date -r {} "+%Y/%m/%d %H:%M:%S" 2>/dev/null`"' > $ArchiveBase
      git diff --name-status $1 HEAD | sed -e 's/	/,/g' > $ArchiveStatus
      git diff --name-only $1 HEAD | xargs ls -l | awk -v OFS=, '{print $9,$5}' > $ArchiveSize
      git archive --format=zip --prefix=archive/ HEAD `git diff --name-only --diff-filter=ACMR $1 HEAD` -o $zip
  else
      git diff --name-only $2 $1 | xargs -I {} sh -c 'echo {},"`date -r {} "+%Y/%m/%d %H:%M:%S" 2>/dev/null`"' > $ArchiveBase
      git diff --name-status $2 $1 | sed -e 's/	/,/g' > $ArchiveStatus
      git diff --name-only $2 $1 | xargs ls -l | awk -v OFS=, '{print $9,$5}' > $ArchiveSize
      git archive --format=zip --prefix=archive/ $1 `git diff --name-only --diff-filter=ACMR $2 $1` -o $zip
  fi

  join -t "," -1 1 -2 2 -a 1 -a 2 $ArchiveBase $ArchiveStatus > $ArchiveTemp
  join -t "," -1 1 -2 1 -a 1 -a 2 $ArchiveTemp $ArchiveSize > $ArchiveFiles

  rm $ArchiveFiles
  rm $ArchiveTemp
  rm $ArchiveBase
  rm $ArchiveStatus
  rm $ArchiveSize
}
