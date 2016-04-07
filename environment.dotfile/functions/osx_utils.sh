# 'o' with no arguments opens the current directory
# otherwise opens the given location
unset o
function o() 
{
	if [ $# -eq 0 ]; then
		open .;
	else
		open "$@";
	fi;
}
export -f o && readonly -f o

