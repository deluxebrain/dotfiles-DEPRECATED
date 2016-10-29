#!/usr/env/bash

function main()
{
  local repos_path
  repos_path="$1"

  cd "$repos_path" || return

  echo "Performing custom install for $repos_path" >&2
  # https://valloric.github.io/YouCompleteMe/
  # Requires: cmake, mono, go, rust
  ./install.py \
    --omnisharp-completer \
    --gocode-completer \
    --tern-completer \
    --racer-completer
}

main "$@"
exit $?

