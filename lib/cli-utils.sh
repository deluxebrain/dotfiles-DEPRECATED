#!/usr/bin/env bash

[ -z "${__CLI_UTILS+.}" ] && readonly __CLI_UTILS= || return 0

# Pens
#+ http://linuxcommand.org/lc3_adv_tput.php

# Example usages
#+ To set for all subsequent output
#$ echo -en ${WHITE}${ON_RED}

#+ To output text in specific ped
#$ echo ${WHITE}${ON_RED}...${PEN_RESET}

export STYLE_BOLD; STYLE_BOLD="$(tput bold)"
export STYLE_REV; STYLE_REV="$(tput rev)"
export STYLE_UNDERLINE_START; STYLE_UNDERLINE_START="$(tput smul)"
export STYLE_UNDERLINE_STOP; STYLE_UNDERLINE_STOP="$(tput rmul)"
export STYLE_STANDOUT_START; STYLE_STANDOUT_START="$(tput smso)"
export STYLE_STANDOUT_END; STYLE_STANDOUT_END="$(tput rmso)"
export STYLE_RESET; STYLE_RESET="$(tput sgr0)"

export BLACK; BLACK="$(tput setaf 0)"
export BLUE; BLUE="$(tput setaf 33)"
export CYAN; CYAN="$(tput setaf 37)"
export GREEN; GREEN="$(tput setaf 64)"
export ORANGE; ORANGE="$(tput setaf 166)"
export PURPLE; PURPLE="$(tput setaf 125)"
export RED; RED="$(tput setaf 1)"
export VIOLET; VIOLET="$(tput setaf 61)"
export WHITE; WHITE="$(tput setaf 15)"
export YELLOW; YELLOW="$(tput setaf 136)"
export NC; NC="$(tput setaf 9)"

export BBLACK=${STYLE_BOLD}${BLACK}
export BBLUE=${STYLE_BOLD}${BLUE}
export BCYAN=${STYLE_BOLD}${CYAN}
export BGREEN=${STYLE_BOLD}${GREEN}
export BORANGE=${STYLE_BOLD}${ORANGE}
export BPURPLE=${STYLE_BOLD}${PURPLE}
export BRED=${STYLE_BOLD}${RED}
export BVIOLET=${STYLE_BOLD}${VIOLET}
export BWHITE=${STYLE_BOLD}${WHITE}
export BYELLOW=${STYLE_BOLD}${YELLOW}

export ON_BLACK; ON_BLACK="$(tput setab 0)"
export ON_BLUE; ON_BLUE="$(tput setab 33)"
export ON_CYAN; ON_CYAN="$(tput setab 37)"
export ON_GREEN; ON_GREEN="$(tput setab 64)"
export ON_ORANGE; ON_ORANGE="$(tput setab 166)"
export ON_PURPLE; ON_PURPLE="$(tput setab 125)"
export ON_RED; ON_RED="$(tput setab 1)"
export ON_VIOLET; ON_VIOLET="$(tput setab 61)"
export ON_WHITE; ON_WHITE="$(tput setab 15)"
export ON_YELLOW; ON_YELLOW="$(tput setab 136)"
export ON_NC; ON_NC="$(tput setab 9)"

export PEN_RESET=${NC}${STYLE_RESET}
export PEN_WARN=${BWHITE}${ON_ORANGE}
export PEN_ALERT=${BWHITE}${ON_RED}
export PEN_HIGHLIGHT=${BYELLOW}${ON_BLUE}
export PEN_INFO=${BBLUE}${ON_WHITE}
export PEN_OK=${BGREEN}${ON_WHITE}
export PEN_DEBUG=${BORANGE}${ON_WHITE}

# Pretty print

function msg_info()
{
  printf " [ %s..%s ] %s\n" "${PEN_INFO}" "${PEN_RESET}" "$1"
}

function msg_debug()
{
  printf " [ %sDEBUG%s ] %s\n" "${PEN_DEBUG}" "${PEN_RESET}" "$1"
}

function msg_prompt()
{
  printf " [ %s???%s ] %s\n" "${PEN_INFO}" "${PEN_RESET}" "$1"
}

function msg_ok()
{
  printf " [ %sOK%s ] %s\n" "${PEN_OK}" "${PEN_RESET}" "$1"
}

function msg_warn()
{
  printf " [ %sWARNING%s ] %s\n" "${PEN_WARN}" "${PEN_RESET}" "$1" >&2
}

function msg_error()
{
  printf " [ %sERROR%s ] %s\n" "${PEN_ALERT}" "${PEN_RESET}" "$1" >&2
}

function fail()
{
  printf " [ %sFAIL%s ] %s\n" "${PEN_ALERT}" "${PEN_RESET}" "$1" >&2
  exit 1
}

