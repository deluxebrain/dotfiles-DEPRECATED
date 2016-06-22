#!/bin/sh

# Find the installation directory of a pip package
unset piproot
 piproot()
{
	pip show "$1" | grep Location | awk '{print $2}' | ( read -r x; echo "${x%/}" )
}
export -f piproot && readonly -f piproot

