#!/usr/env bash

function main()
{
  local repos_path
  repos_path="$1"

  cd "$repos_path" || return

  echo "Performing custom install for $repos_path" >&2
  # Tern requires node.js and npm to be installed
  # The tern server is installed by running npm install in the plugin directory
  npm install
}

main "$@"
exit $?

