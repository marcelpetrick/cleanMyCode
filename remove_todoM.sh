#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to fix the issue with running bash-scripts under cygwin
# script from hacker-man Marcel Petrick to remove all his superfluous debug-code in one washing-up!
# date 20170513

IFS=$'\n'; #filename with spaces-issue ..

for filename in $(find . -name '*.h' -or -name '*.cpp');
do
	# check first if the file contains the string at all! to prevent unnecesary touched files
	if grep -Fxq "todoM" $filename
	then
		echo "$filename"
		sed -n '/todoM/!p' $filename > tempfile
		mv tempfile $filename
	fi
done
