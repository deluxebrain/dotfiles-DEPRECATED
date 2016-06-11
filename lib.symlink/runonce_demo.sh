#!/usr/bin/env bash

# -z			Check for not set or null
# ${parameter+word}	Parameter expansion: substitute word in all cases except
#			for parameter being unset (including zero length)
# NOTE - explicitly return 0 as default will be the 1 from the test
[ -z "${__FILE+.}" ] && readonly __FILE= || return 0

echo "script sourced"

