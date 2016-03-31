#!/bin/bash

# interactive login shells
#+ /etc/profile
#+ /etc/profile.d/
#+ ~/.bash_profile

# interactive non-login shells
#+ /etc/bashrc
#+ ~/.bashrc

# non-interactive shells
#+ $BASH_ENV (if set, usually points to ~/.bashrc)

# Simple test for interactive shell
#$ is_interactive? && echo 'interactive shell'
unset is_interactive
function is_interactive()
{
	# $-	| current options set for the shell
	[[ $- == *i* ]] 
	return
}
export -f is_interactive && readonly -f is_interactive

# Simple test for login shell
#$ is_login? && echo 'login shell'
unset is_login
function is_login()
{
	# shopt		| bash set options
	# login_shell	| read-only shell descriptor set by then shell when is login shell
	shopt -q login_shell
	return
}
export -f is_login && readonly -f is_login

# Unify help and man
# http://unix.stackexchange.com/a/18088/77581
unset manup
function manup()
{
        case "$(type -t "$1")" in
                # ${parameter:-word}
                #+ If 'parameter' is unset or null use the expansion of 'word'
                builtin) help "$1" | "${PAGER:-less}";;         # builtin
                *) command -p man "$@";;                        # external command
        esac
}
export -f manup && readonly -f manup
