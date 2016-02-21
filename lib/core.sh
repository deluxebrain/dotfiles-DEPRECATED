#!/bin/bash

[ -z "${__CORE+.}" ] && readonly __CORE= || return 0

function __exit_handler()
{
	rm "$ERR_PIPE"
	exec 3>&-
}

function __error_handler()
{
	echo "here"
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
        printf " [ ${PEN_INFO}..${PEN_RESET} ] $1\n"
}

function msg_prompt() 
{
        printf " [ ${PEN_INFO}?${PEN_RESET} ] $1\n"
}

function msg_ok() 
{
        printf " [ ${PEN_OK}OK${PEN_RESET} ] $1\n"
}

function msg_warn()
{
	printf " [ ${PEN_WARN}WARNING${PEN_RESET} ] $1\n"
}

function msg_error()
{
	printf " [ ${PEN_ALERT}ERROR${PEN_RESET} ] $1\n"
}

function fail() 
{
        printf " [ ${PEN_ALERT}FAIL${PEN_RESET} ] $1\n"
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
