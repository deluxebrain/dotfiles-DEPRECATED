#!/bin/bash

function main() 
{
    # 1. Get local cached origin info (-n)
    # 2. Extract the line with the URL
    # 3. Split the line to get the URL
    # 4. Get the repos name from the URL basename with .git removed
    git remote show origin -n |\
	grep "Fetch URL" |\
	awk -F': ' '{print $2}' |\
	xargs -I"{}" basename "{}" .git
}

main "$@" && exit 0
exit 1

