#!/bin/bash

# 'v' with no arguments opens the current directory in Vim
# otherwise opens the given location
unset v
function v()
{
  if [ $# -eq 0 ]; then
    vim .;
  else
    vim "$@";
  fi;
}
export -f v && readonly -f v

unset vup
function vup()
(
  local d

  cd "${HOME}"/.vim || exit 1
  for d in ./bundle/*
  do
  (
    echo "Updating $(basename "$d")"
    cd "$d" || exit 1
    git submodule update --recursive
  )
  done

  git add bundle > /dev/null
  git commit -m "Updated all vim plugins" > /dev/null
  git push origin master > /dev/null
)
export -f vup && readonly -f vup

