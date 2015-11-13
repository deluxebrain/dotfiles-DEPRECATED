#!/bin/bash

# Syntax-highlight JSON strings or files
#+Usage: 
#$ json '{"foo":42}' 
#$ echo '{"foo":42}' | json

function main() 
{
    if [ -t 0 ]; then # argument
      # $* - expand all arguments into a single double quoted string
      # $@ - expands all arguments and double quotes then all individually
      # <<< - here string
       python -mjson.tool <<< "$*" | pygmentize -l javascript;
    else # pipe
        python -mjson.tool | pygmentize -l javascript;
    fi;
}

result=$(main "$@")
if [ $? -eq 0 ]; then
	echo "$result"
	exit 0
fi

exit 1
