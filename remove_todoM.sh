#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to fix the issue with running bash-scripts under cygwin

# script from hacker-man Marcel Petrick to remove all his superfluous debug-code in one washing-up!
# questions, answers: mail@marcelpetrick.it
# date: 20170519
# version: 4
# todo: make the searchstring case-independent and maybe some variable ..
# todo: make it use GNU parallel

IFS=$'\n'; #deal with the "filename with spaces"-issue ..

echo "## BEGIN ##"
checkAndFix() {
	# check first if the file contains the string at all to prevent unnecessary touched files
	if grep -q -i 'todoM' $1; then
		echo "clean now: $1"
		# replace all
		sed -n '/todoM/!p' $1 > tempfile
		mv tempfile $1
	fi
}
export -f checkAndFix # needed to make it known and useable with GNU parallel

# the workhorse ..
echo "0. create now the file-result-list"
FILELIST=`find . -name '*.h' -or -name '*.cpp'` # get all files inside the current folder which fit by suffix
#echo "1. print now the list: $FILELIST"
#exit 1
echo "2. calling now GNU parallel"
parallel  -j16 --bar checkAndFix ::: $FILELIST
echo "## DONE :) ##"

exit 1
