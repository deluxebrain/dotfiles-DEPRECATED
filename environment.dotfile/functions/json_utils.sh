#!/bin/bash
#
# pretty print json
unset jpp
function jpp()
{
	jq '.' < "$1"
}
export -f jpp && readonly -f jpp

