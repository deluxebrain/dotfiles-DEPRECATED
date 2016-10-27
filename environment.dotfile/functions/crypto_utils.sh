#!/bin/bash

unset sha1_chksum
sha1_chksum()
{
  if [ -z "$1" ]; then
    echo "Usage: sha1_chksum <file>"
    return 2
  fi

  # no idea why I need to force the tee >() through bash when its running in bash to begin with ...
  openssl sha1 "$1" | awk '{print $2}' | bash -c 'tee >(tr -d "\n" | pbcopy)'
}
export -f sha1_chksum && readonly -f sha1_chksum

