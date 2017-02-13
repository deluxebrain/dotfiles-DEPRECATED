#!/bin/bash

# change directory and list it
unset cdl
function cdl()
{
  cd "$@" && ls
}
export -f cdl && readonly -f cdl

# Create a new directory and enter it
unset mkd
function mkd()
{
  mkdir -p "$@" && cd "$_" || exit 1
}
export -f mkd && readonly -f mkd

# 'tre' is a shorthand for 'tree' with hidden files and color enabled, ignoring
# the '.git' directory, listing directories first.
# The output gets piped into 'less' with options to preserve color and line numbers,
# unless the output is small enough for one screen.
unset tre
function tre()
{
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | ${PAGER:-less} -FRNX;
}
export -f tre && readonly -f tre

unset t2s
function t2s()
{
  expand -t 2 "$1" | sponge "$1"
}
export -f t2s && readonly -f t2s

