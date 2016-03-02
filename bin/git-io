#!/bin/bash

# Create a git.io short URL

function main() 
{
    if [ -z "${1}" ]; then
        echo "Usage: \`gitio url (slug)\`";
        false
	return
    fi;

    local slug 

    [ -n "${2}" ] && slug="-F \"code="${2}"\""
    curl -s -i http://git.io/ -F "url=${1}" ${slug} | grep Location | awk {'print $2'} 
}

result="$(main "$@")"
if (( $? == 0 )) && [ -a "$result" ]; then
	echo "$result"
	exit 0
fi

exit 1

