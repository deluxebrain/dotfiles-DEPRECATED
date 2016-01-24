#!/bin/bash

# -z			Check for not set or null
# ${parameter+word}	Parameter expansion: substitute word in all cases except
#			for parameter being unset (including zero length)
[ -z ${__FILE+.} ] && readonly __FILE= || return

echo "script sourced"

