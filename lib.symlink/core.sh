#!/bin/bash

[ -z "${__CORE+.}" ] && readonly __CORE= || return 0

#-------------------------------------------------------------
# Pens
#+ http://linuxcommand.org/lc3_adv_tput.php
#-------------------------------------------------------------

# Example usages
#+ To set for all subsequent output
#$ echo -en ${WHITE}${ON_RED}

#+ To output text in specific ped
#$ echo ${WHITE}${ON_RED}...${PEN_RESET}

export STYLE_BOLD="$(tput bold)"
export STYLE_REV="$(tput rev)"
export SYTLE_UNDERLINE_START="$(tput smul)"
export STYLE_UNDERLINE_STOP="$(tput rmul)"
export STYLE_STANDOUT_START="$(tput smso)"
export STYLE_STANDOUT_END="$(tput rmso)"
export STYLE_RESET="$(tput sgr0)"

export BLACK="$(tput setaf 0)"
export BLUE="$(tput setaf 33)"
export CYAN="$(tput setaf 37)"
export GREEN="$(tput setaf 64)"
export ORANGE="$(tput setaf 166)"
export PURPLE="$(tput setaf 125)"
export RED="$(tput setaf 1)"
export VIOLET="$(tput setaf 61)"
export WHITE="$(tput setaf 15)"
export YELLOW="$(tput setaf 136)"
export NC="$(tput setaf 9)"

export BBLACK=${STYLE_BOLD}${BLACK}
export BBLUE=${STYLE_BOLD}${BLUE}
export BCYAN=${STYLE_BOLD}${CYAN}
export BGREEN=${STYLE_BOLD}${GREEN}
export BORANGE=${STYLE_BOLD}${ORANGE}
export BPURPLE=${STYLE_BOLD}${PURPLE}
export BRED=${STYLE_BOLD}${RED}
export BVIOLET=${STYLE_BOLD}${VIOLET}
export BWHITE=${STYLE_BOLD}${WHITE}
export BYELLOW=${STYLE_BOLD}${YELLOW}

export ON_BLACK="$(tput setab 0)"
export ON_BLUE="$(tput setab 33)"
export ON_CYAN="$(tput setab 37)"
export ON_GREEN="$(tput setab 64)"
export ON_ORANGE="$(tput setab 166)"
export ON_PURPLE="$(tput setab 125)"
export ON_RED="$(tput setab 1)"
export ON_VIOLET="$(tput setab 61)"
export ON_WHITE="$(tput setab 15)"
export ON_YELLOW="$(tput setab 136)"
export ON_NC="$(tput setab 9)"

export PEN_RESET=${NC}${STYLE_RESET}
export PEN_WARN=${BWHITE}${ON_ORANGE}
export PEN_ALERT=${BWHITE}${ON_RED}
export PEN_HIGHLIGHT=${BYELLOW}${ON_BLUE}
export PEN_INFO=${BBLUE}${ON_WHITE}
export PEN_OK=${BGREEN}${ON_WHITE}

#-------------------------------------------------------------
# Global error handlers
#-------------------------------------------------------------

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

	# We need to read through all the lines to get to the last one
	# (which will be the error)
	# Note - this will block waiting for more input
	# Hence the timeout option on the read
	while read -r -t 1 message; do
		echo "$message"
	done <"$ERR_PIPE" 
	
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

	# Dont exit the script if any statement returns a non-true return code
	# (We want out error handler to fire instead)
	set +o errexit

	# create a temporary named pipe
	ERR_PIPE="$(mktemp -u)"
	mkfifo "$ERR_PIPE"

	# Redirect stderr to the fifo pipe via tee
	# Note tee splits to a file and stdin hence we need to redirect stdin back to stderr
	exec 2> >(tee "$ERR_PIPE" >&2)  
	
	# wire up exit and error handlers
	trap '__exit_handler' EXIT
	trap '__error_handler ${LINENO} $?' ERR
}

#-------------------------------------------------------------
# Script debugging and tracing
#-------------------------------------------------------------

_DEBUG=false	  # Set to true to echo instead of executing a command
_TRACE=false	  # Set to true to trace a command to stdout
function DEBUG()
{
	if $_DEBUG; then
		echo "[DEBUG] $*"
	elif $_TRACE; then
		(
			set -o xtrace
			eval "$*"
		) 
	else
		eval "$*"
	fi
}

#-------------------------------------------------------------
# Pretty print
#-------------------------------------------------------------

function msg_info() 
{
        printf " [ %s..%s ] %s\n" "${PEN_INFO}" "${PEN_RESET}" "$1"
}

function msg_prompt() 
{
        printf " [ %s?%s ] %s\n" "${PEN_INFO}" "${PEN_RESET}" "$1"
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

#-------------------------------------------------------------
# Functional helpers
#-------------------------------------------------------------

function _join()
{
	# Set expansion character
	local IFS="$1"

	# shift past the first argument (the separator)
	shift

	# Expand args to "$1c$2c..." where c is first character if IFS
	echo "$*"
}

