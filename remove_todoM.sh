#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required
# script from hacker-man Marcel Petrick to remove all his superfluous debug-code in one washing-up!

IFS=$'\n';

for filename in $(find . -name '*.h' -or -name '*.cpp');
do
	echo "$filename"
	sed -n '/todoM/!p' $filename > tempfile
	mv tempfile $filename
done
