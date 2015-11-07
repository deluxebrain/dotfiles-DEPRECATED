#!/bin/bash

function msg_info() 
{
        printf " [ ${PEN_YELLOW}..${PEN_RESET} ] $1\n"
}

function msg_prompt() 
{
        printf " [ ${PEN_BLUE}?${PEN_RESET} ] $1\n"
}

function msg_ok() 
{
        printf " [ ${PEN_GREEN}OK${PEN_RESET} ] $1\n"
}

function msg_warn()
{
	printf " [ ${PEN_WARN}WARNING${PEN_RESET} ] $1\n"
}

function msg_fail() 
{
        printf " [ ${PEN_ALERT}FAIL${PEN_RESET} ] $1\n"
        exit
}

export -f msg_info && readonly -f msg_info
export -f msg_prompt && readonly -f msg_prompt
export -f msg_success && readonly -f msg_success
export -f msg_warn && readonly -f msg_warn
export -f msg_fail && readonly -f msg_fail
