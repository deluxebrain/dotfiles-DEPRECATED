#!/bin/bash

while IFS= read -r; do
	lines+=("$REPLY")
done < brew-apps
[[ $REPLY ]] && lines+=("$REPLY")

echo "${lines[@]}"
