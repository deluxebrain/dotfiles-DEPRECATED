[ -z ${__PATH+.} ] && readonly __PATH= || return

function path_combine()
{
        _join "/" "${@%/}"
}

