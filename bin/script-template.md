``` shell
#!/bin/bash

# Get path of currently executing script
CWD="${BASH_SOURCE%/*}" 

# Configure our dependencies
DEPENDS_ON=(~/bin/dependency-1.sh \
        ~/bin/dependency-2.sh)

# Define script entry point
# Run in subshell so that all changes to environment are transient
__main () (
	# Declare all global variables
	# Subshell scoping prevents these contaminating environment of parent shell
	g_variable_1="..."

	# Load dependencies
        for FILE in "${DEPENDS_ON[@]}"; do source "${CWD}/${FILE}"; done

	# Do stuff ...
	__func_1

	# exit properly
	exit 0
)

# Forward declcare all functions
# Public functions (to be exported)
public_func () {
}

# Private functions should begin __
__func_1 () {
	# Declare local variables
	# Note, local scopes to current and all called functions
	local variable_1="..."
}

# Call the entry point, passing through all positional parameters
__main "$@"

# Export and protect all public functions
export -f public_func && readonly -f public_func

# Remove all environmental side affects
unset CWD
unset DEPENDS_ON

unset -f __main
unset -f __func_1
```
