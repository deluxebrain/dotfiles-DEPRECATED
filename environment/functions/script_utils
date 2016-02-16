unset DEPENDS_ON
function DEPENDS_ON()
{
	if [[ -z "${LIB_PATH}" || ! -d "${LIB_PATH}" ]]; then
		echo "LIB_PATH not set or not valid path" 2>&1
		return 1
	fi  

	local FILES=("$@" "core")
	local FILE
	for FILE in "${FILES[@]}"
	do
		source "${LIB_PATH}/${FILE}.sh" > /dev/null 2>&1  || 
		{
			echo "Failed to source ${FILE}.sh" 2>&1
			return 1
		}
	done
}
export -f DEPENDS_ON && readonly -f DEPENDS_ON
