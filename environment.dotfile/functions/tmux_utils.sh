#!/bin/bash

# Override the exit command so that it:
# - kills the current tmux session
# - closes the window ( works because the tmux session was created via exec )
# If not in tmux sesison or if multiple panes then use builtin exit
unset exit
function exit()
{
	local panes 

	if [ -z "${TMUX}" ]; then
		builtin exit
	else
		panes=$(tmux list-panes | wc -l)
		if (( panes > 1 )); then
			builtin exit
		else
			# Close the current window and detach from the session
			# NOTE this appears to be the only way to achieve this ...
			# 1. As soon as you kill the window this function will stop running
			# 2. If you just "detach" then session and iterm console are destroyed
			#	but the window remains attached to the parent session
			tmux kill-window \; detach
		fi
	fi
}
export -f exit && readonly -f exit

