#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to fix the issue with running bash-scripts under cygwin

# what is this? a script to remove all his superfluous debug-code in one washing-up!
# author: mail@marcelpetrick.it
# date: 20170521
# version: 6
# how to use: call "./remove_todoM.sh PREFERRRED_MARKER" in bash/cygwin
# features: first argument has to be the search-string: if empty, then "todoM" is used
# in case git is not used, activate the outcommented line with "find" instead

IFS=$'\n'; #deal with the "filename with spaces"-issue ..

echo "## BEGIN ##"
# arg $1 is the search-string
# arg $2 is the filename
checkAndFix() {
    #echo "check now file: $2 with argument $1"
    # check first if the file contains the string at all to prevent unnecessary touched files
    if grep -q -i $1 $2; then
        echo "HIT! clean now file: $2"
        # replace all
        sed -n "/$1/!p" $2 > tempfile
        mv tempfile $2
    fi
}
export -f checkAndFix # needed to make it known and useable with GNU parallel

################################
## real functionality follows ##
################################
# check if no argument was given - replace in that case with my choice
if [ -z "${1}" ]; then
    echo "argument has not been set: will fall back to 'todoM'"
    set -- todoM
fi
echo "used argument will be $1" #just for testing purposes

echo "create now the file-result-list"

CURRENTBRANCH=`git rev-parse --abbrev-ref HEAD`
echo "print now the current branch: $CURRENTBRANCH"
#FILELIST=`find . -name '*.h' -or -name '*.cpp'` # get all files inside the current folder which fit by suffix
FILELIST=`git diff --name-only master $CURRENTBRANCH --no-merges | grep -e '\.cpp$' -e '\.h$'` #$ at grep matches end of line; to check just for files which end with h/cpp
echo "print now the FILELIST cpp: $FILELIST"

echo "calling now GNU parallel"
parallel  -j16 --bar checkAndFix ::: $1 ::: $FILELIST
echo "## DONE :) ##"

exit 0

