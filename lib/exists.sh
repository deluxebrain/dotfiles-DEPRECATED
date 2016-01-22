# Collection of utility functions around testing for the existence of stuff

[ -z ${__EXISTS+.} ] && readonly __EXISTS= || return

function dir_exists?()
{
	[ -n "$1" -a -d "$1" ]
}

function file_exists?() 
{
        local path=$1

        # check if paths  exists (in one of various forms)
        # note a function that ends without an explcit return statement
        # returns the exit code of the last executed command
        #  [            : Test with pathname expansion (as opposed to [[)
        #  "$path"      : Treat expanded path as a literal
        #  -o           : OR the conditions together
        # -f            : file exists
        # -d            : file exists and is a directory
        # -L            : file exists and is a symlink
        [ -f "$path" -o -d "$path" -o -L "$path" ]
}

function app_exists?() 
{
        local app=$1
        # command-v	: Describe a command without executing it, exit 1 if doesn't exist
        command -v $($app) &> /dev/null
}

