function msg_info() 
{
        printf " [ ${PEN_YELLOW}..${PEN_RESET} ] $1\n"
}
export -f msg_info && readonly -f msg_info

function msg_prompt() 
{
        printf " [ ${PEN_BLUE}?${PEN_RESET} ] $1\n"
}
export -f msg_prompt && readonly -f msg_prompt

function msg_ok() 
{
        printf " [ ${PEN_GREEN}OK${PEN_RESET} ] $1\n"
}
export -f msg_ok && readonly -f msg_ok

function msg_warn()
{
	printf " [ ${PEN_WARN}WARNING${PEN_RESET} ] $1\n"
}
export -f msg_warn && readonly -f msg_warn

function msg_fail() 
{
        printf " [ ${PEN_ALERT}FAIL${PEN_RESET} ] $1\n"
        exit
}
export -f msg_fail && readonly -f msg_fail

