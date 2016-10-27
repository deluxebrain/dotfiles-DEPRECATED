#!/bin/bash

unset DEPENDS_ON
function DEPENDS_ON()
{
  if [[ -z "${LIB_PATH}" || ! -d "${LIB_PATH}" ]]; then
    echo "LIB_PATH not set or not valid path" 2>&1
    return 1
  fi

  local FILES=("$@" "core")
  local FILE
  for FILE in "${FILES[@]}"
  do
    # shellcheck source=/dev/null
    source "${LIB_PATH}/${FILE}.sh" > /dev/null 2>&1  ||
    {
      echo "Failed to source ${FILE}.sh" 2>&1
      return 1
    }
  done
}
export -f DEPENDS_ON && readonly -f DEPENDS_ON

unset join
function join()
{
  # Set expansion character
  local IFS="$1"

  # shift past the first argument (the separator)
  shift

  # Expand args to "$1c$2c..." where c is first character if IFS
  echo "$*"
}
export -f join && readonly -f join

unset render_template
function render_template()
{
  eval "echo \"$(cat "$1")\""
}
export -f render_template && readonly -f render_template

