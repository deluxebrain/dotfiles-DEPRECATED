[ -z ${__PROMPT+.} ] && readonly __PROMPT= || return

function msg_info() 
{
        printf " [ ${PEN_INFO}..${PEN_RESET} ] $1\n"
}

function msg_prompt() 
{
        printf " [ ${PEN_INFO}?${PEN_RESET} ] $1\n"
}

function msg_ok() 
{
        printf " [ ${PEN_OK}OK${PEN_RESET} ] $1\n"
}

function msg_warn()
{
	printf " [ ${PEN_WARN}WARNING${PEN_RESET} ] $1\n"
}

function msg_error()
{
	printf " [ ${PEN_ALERT}ERROR${PEN_RESET} ] $1\n"
}

function fail() 
{
        printf " [ ${PEN_ALERT}FAIL${PEN_RESET} ] $1\n"
        exit 1
}

