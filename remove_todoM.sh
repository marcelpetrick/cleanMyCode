#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to fix the issue with running bash-scripts under cygwin

# script from hacker-man Marcel Petrick to remove all his superfluous debug-code in one washing-up!
# date: 20170519
# version: v3

# todo: make the searchstring case-independent
# todo: make it use GNU parallel

IFS=$'\n'; #deal with the "filename with spaces"-issue ..

doit() {
	echo Doing it for $1
	sleep 2
	echo Done with $1
 }
 export -f doit
 parallel  -j8 --bar doit ::: 1 2 3 5 6 
 
 exit 1

# go over all subdirectories
for filename in $(find . -name '*.h' -or -name '*.cpp'); do
	# check first if the file contains the string at all to prevent unnecessary touched files
	if grep -q -i 'todoM' $filename; then
		echo "clean now: $filename"
		sed -n '/todoM/!p' $filename > tempfile
		mv tempfile $filename
	fi
done
