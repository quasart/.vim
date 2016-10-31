#!/bin/bash


# basic commands

alias ls='ls --color=auto'
alias ll='ls -l'
alias watch='watch '
alias psme='ps -edf | grep $USER | grep -v "grep $USER"'
alias gtree='git log --graph --oneline --all --decorate --color '


# formatting

alias now_timestamp='date +%Y%m%d_%H%M%S'
alias column_tab='column -t -s"	" -n'
color_err()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1


# basic scripts

wiki()
{
	lynx -use_mouse -anonymous -nocolor -editor=vim https://fr.wikipedia.org/wiki/`echo $@ | tr ' ' '_'`
}


# prompt

#COLOR_dark="\[\e[0;30m\]"
#COLOR_red="\[\e[0;31m\]"
COLOR_green="\[\e[0;32m\]"
#COLOR_yellow="\[\e[0;33m\]"
#COLOR_blue="\[\e[0;34m\]"
COLOR_cyan="\[\e[0;36m\]"
#COLOR_white="\[\e[0;37m\]"

#COLOR_DARK="\[\e[1;30m\]"
#COLOR_RED="\[\e[1;31m\]"
#COLOR_GREEN="\[\e[1;32m\]"
#COLOR_YELLOW="\[\e[1;33m\]"
#COLOR_BLUE="\[\e[1;34m\]"
COLOR_CYAN="\[\e[1;36m\]"
#COLOR_WHITE="\[\e[1;37m\]"

COLOR_NONE="\[\e[0;00m\]"

PS1="${COLOR_cyan}\u@\h:${COLOR_CYAN}\w${COLOR_green} >${COLOR_NONE}"

