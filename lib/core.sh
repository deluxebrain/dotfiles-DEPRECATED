#!/bin/bash

[ -z "${__CORE+.}" ] && readonly __CORE= || return 0

function __exit_handler()
{
	# Clean up the named pipe thats been used for storing stderr
	rm "$ERR_PIPE"
	exec 3>&-
}

function __error_handler()
{
	local message
	local line_no
	local code

	message="$(head -n1 < "$ERR_PIPE")" 
	line_no="$1"
	code="${2:-1}"
	msg_error "Error on line ${line_no}: ${message}; exiting with status ${code}"
	exit "${code}"
}

function USE_GLOBAL_ERROR_HANDLER()
{
	# Inherit traps on ERR within shell functions, command substitutions and subshells
	set -o errtrace

	# Cause any failure anywhere in a pipeline to cause the entire pipeline to fail
	set -o pipefail

	# Exit the script on any attempt to use an uninitialized variable
	set -o nounset

	# Exit the script if any statement returns a non-true return code
	set -o errexit

	# create a temporary named pipe
	ERR_PIPE="$(mktemp -u)"
	mkfifo "$ERR_PIPE"

	# redirect file descriptor 3 to stdout
	exec 3>&1

	# redirect all stdout to the temporary named pipe, filtering on stderr
	exec > >(tee "$ERR_PIPE") 2>&1 1>&3
	
	# wire up exit and error handlers
	trap '__exit_handler' EXIT
	trap '__error_handler ${LINENO} $?' ERR
}

function msg_info() 
{
        printf " [ %s..%s ] %s\n" "${PEN_INFO}" "${PEN_RESET}" "$1"
}

function msg_prompt() 
{
        printf " [ %s?%s ] %s\n" "${PEN_INFO}" "{PEN_RESET}" "$1"
}

function msg_ok() 
{
        printf " [ %sOK%s ] %s\n" "${PEN_OK}" "${PEN_RESET}" "$1"
}

function msg_warn()
{
	printf " [ %sWARNING%s ] %s\n" "${PEN_WARN}" "${PEN_RESET}" "$1"
}

function msg_error()
{
	printf " [ %sERROR%s ] %s\n" "${PEN_ALERT}" "${PEN_RESET}" "$1"
}

function fail() 
{
        printf " [ %sFAIL%s ] %s\n" "${PEN_ALERT}" "${PEN_RESET}" "$1"
        exit 1
}

function _join()
{
	# Set expansion character
	local IFS="$1"

	# shift past the first argument (the separator)
	shift

	# Expand args to "$1c$2c..." where c is first character if IFS
	echo "$*"
}
