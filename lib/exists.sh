#!/usr/bin/env bash

# Collection of utility functions around testing for the existence of stuff

[ -z "${__EXISTS+.}" ] && readonly __EXISTS= || return 0

function dir_exists?()
{
  [ -n "$1" ] && [ -d "$1" ]
}

function file_exists?()
{
  local path=$1

  # check if paths  exists (in one of various forms)
  # note a function that ends without an explcit return statement
  # returns the exit code of the last executed command
  [ -n "$1" ] && [ -f "$path" ]
}

function app_exists?()
{
  local app=$1
  # command-v	: Describe a command without executing it, exit 1 if doesn't exist
  command -v "$($app)" &> /dev/null
}

