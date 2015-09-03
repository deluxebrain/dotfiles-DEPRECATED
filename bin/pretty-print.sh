#!/bin/bash

print_info () {
        printf " [ ${PEN_YELLOW}..${PEN_RESET} ] $1\n"
}

print_prompt () {
        printf " [ ${PEN_BLUE}?${PEN_RESET} ] $1\n"
}

print_success () {
        printf " [ ${PEN_GREEN}OK${PEN_RESET} ] $1\n"
}

fail_and_exit () {
        printf " [ ${PEN_RED}FAIL${PEN_RESET} ] $1\n"
        exit
}

export -f print_info && readonly -f print_info
export -f print_prompt && readonly -f print_prompt
export -f print_success && readonly -f print_success
export -f fail_and_exit && readonly -f fail_and_exit
