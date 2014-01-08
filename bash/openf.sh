#!/bin/sh

if [ $# -ne 0 -a $# -gt 2 ]; then
	echo "Parameter error. ($#/2)"
	echo "Need string to search."
	echo "  Case1 : openf.sh $filename"
	echo "  Case2 : openf.sh $filename $greppath"
	exit 1
fi

OPEN_FILE_PATH=""
SEARCH_STRING=$1
PATH_STRING=""
QUERY=""
QUERY_FIND=""
QUERY_GREP=""
NUM=0


# option 1 file string
if [ $# -gt 0 ]; then
	QUERY_FIND="find ./* -name ${SEARCH_STRING}"
	QUERY=${QUERY_FIND} 
fi


# option 2 grep string
if [ $# -gt 1 ]; then
	PATH_STRING=$2
	QUERY_FIND="find ./* -name ${SEARCH_STRING}"
	QUERY_GREP=" | grep ${PATH_STRING}"
	QUERY=${QUERY_FIND}${QUERY_GREP}
fi


NUM=`eval ${QUERY} | wc -l`

if [ ${NUM} -eq 0 ]; then
	echo "File is not found."
	exit;
fi

if [ ${NUM} -gt 1 ]; then
	echo "Targetted file too many."
	eval ${QUERY}
	exit;
fi

OPEN_FILE_PATH=`eval ${QUERY}`
echo "File open -> ${OPEN_FILE_PATH}"

open ${OPEN_FILE_PATH}
