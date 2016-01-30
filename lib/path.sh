#!/bin/bash

[ -z ${__PATH+.} ] && readonly __PATH= || return 0

function path_combine()
{
        _join "/" "${@%/}"
}

