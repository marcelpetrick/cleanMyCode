#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to fix the issue with running bash-scripts under cygwin

# script from hacker-man Marcel Petrick to remove all his superfluous debug-code in one washing-up!
# date: 20170513
# version: v2

# todo: make the searchstring case-independent
# todo: make it use GNU parallel

IFS=$'\n'; #deal with the "filename with spaces"-issue ..

# go over all subdirectories
for filename in $(find . -name '*.h' -or -name '*.cpp'); do
	# check first if the file contains the string at all to prevent unnecessary touched files
	if grep -q -i 'todoM' $filename; then
		echo "clean now: $filename"
		sed -n '/todoM/!p' $filename > tempfile
		mv tempfile $filename
	fi
done

