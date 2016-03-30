# 'v' with no arguments opens the current directory in Vim
# otherwise opens the given location
unset v
function v() 
{
	if [ $# -eq 0 ]; then
		vim .;
	else
		vim "$@";
	fi;
}
export -f v && readonly -f v

unset vup
function vup()
(
	cd "$HOME/.vim"
	local d
	for d in ./bundle/*
	do
	( 
		echo "Updating $(basename "$d")"
		cd "$d"
		git submodule update --recursive 
	)
	done

	git add bundle > /dev/null
	git commit -m "Updated all vim plugins" > /dev/null
	git push origin master > /dev/null
)
export -f vup && readonly -f vup
