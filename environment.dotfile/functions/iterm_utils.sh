#!/bin/bash

# https://www.iterm2.com/documentation-escape-codes.html
# iTerm2 supports several non-standard escape codes.
# Note these wont work in tmux or screen without them being sent to the underlying terminal
# See: https://unix.stackexchange.com/questions/157911/whats-a-smart-way-to-use-maintain-two-separate-bash-profiles-and-vimrcs

# Set cursor shape
unset set_iterm_cursor
function set_iterm_cursor()
{
  # Use [[ which allows:
  #+ Expression short circuiting ( replace -o with || )
  if [[ -z "$1" || $1 -lt 0 || $1 -gt 2 ]]; then
    echo "Usage: set_item_cursor cursor"
    echo "0: Block"
    echo "1: Vertical bar"
    echo "2: Underline"
    return 2
  fi

  if [ -n "${TMUX}" ]; then
    echo -ne "\033Ptmux;\033\033]50;CursorShape=$1\007\033\\"
  else
    echo -ne "\033]50;CursorShape=$1\007"
  fi
}
export -f set_iterm_cursor && readonly -f set_iterm_cursor

# Set profile
unset set_iterm_profile
function set_iterm_profile
{
  if [[ -z "$1" ]]; then
    echo "Usage: set_iterm_profile profile"
    return 2
  fi

  if [ -n "${TMUX}" ]; then
    echo -ne "\033Ptmux;\033\033]50;SetProfile=$1\007\033\\"
  else
    echo -ne "\033]50;SetProfile=$1\007"
  fi
}
export -f set_iterm_profile && readonly -f set_iterm_profile

# Bring iTerm2 to the foreground
unset do_iterm_focus
function do_iterm_focus
{
  if [ -n "${TMUX}" ]; then
	  echo -ne "\033Ptmux;\033\033]50;StealFocus\007\033\\"
  else
	  echo -ne "\033]50;StealFocus\007"
  fi
}
export -f do_iterm_focus && readonly -f do_iterm_focus

# Post a Growl notification
unset do_iterm_growl
function do_iterm_growl
{
  if [[ -z "$1" ]]; then
    echo "Usage: do_iterm_growl message"
    return 2
  fi

  if [ -n "${TMUX}" ]; then
    echo -ne "\033Ptmux;\033\033]9;$1\007\033\\"
  else
    echo -ne "\033]9;$1\007"
  fi
}
export -f do_iterm_growl && readonly -f do_iterm_growl

