#!/bin/sh

echo "start"

if [ $# -ne 1 ]; then
	echo "parameter error. ($#/1)"
	echo "need string to search."
	exit 1
fi

SEARCH_STRING=$1

NUM=`find ./* -name ${SEARCH_STRING} | wc -l`

if [ ${NUM} -eq 0 ]; then
	echo "file is not found."
	exit;
fi

if [ ${NUM} -ne 1 ]; then
	echo "targetted file too many."
	find ./* -name ${SEARCH_STRING}
	exit;
fi

open `find ./* -name ${SEARCH_STRING}`
