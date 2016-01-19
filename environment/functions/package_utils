# Find the installation directory of a pip package
unset piproot
function piproot()
{
	pip show $1 | grep Location | awk {'print $2'} | ( read x; echo "${x%/}" )
}
export -f piproot && readonly -f piproot

