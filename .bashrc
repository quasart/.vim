#!/bin/bash


# formatting

alias now_timestamp='date +%Y%m%d_%H%M%S'
alias column_tab='column -t -s"	" -n'
color_err()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1


# bash commands

alias ll='ls -l --color=auto'
alias grep='grep --directories=skip --colour=auto '
alias watch='watch '

alias psme='ps -edf | grep $USER | grep -v "grep $USER"'


# git

git config --global core.editor 'vim'
git config --global diff.tool 'vimdiff'

git config --global alias.s             'status'
git config --global alias.co            'commit'
git config --global alias.ch            'checkout'

git config --global alias.tree          'log --graph --oneline --branches --remotes --tags --decorate --color --max-count=20'
git config --global alias.review        '!git log $1 --max-count=1 && echo "" && git diff --stat $1^..$1 && git difftool $1^..$1'
git config --global alias.amend         'commit --amend -C HEAD'
git config --global alias.fixup         'commit --fixup'

git config --global alias.get-branch    '!git branch 2> /dev/null | grep "^*" | cut -c3-'
git config --global alias.get-status    '!git status --short 2> /dev/null | wc -l | sed -e "s/^/+/" -e "s/+0//"'

#git config --global alias.stat-authors  '!git log | grep "Author:" | sort | uniq -c | sort -nr'
#git config --global alias.stat-blame    '!git ls-tree -r -z --name-only HEAD -- */*.[ch]* | xargs -0 -n1 git blame --line-porcelain HEAD |grep  "^author "|sort|uniq -c|sort -nr'


# web

wiki()
{
	lynx -use_mouse -nopause -anonymous -nocolor -editor=vim https://fr.wikipedia.org/wiki/`echo $@ | tr ' ' '_' | sed 's/^./\U&/'`
	#lynx -dump -nolist -justify -anonymous https://fr.wikipedia.org/wiki/`echo $@ | tr ' ' '_' | sed 's/^./\U&/'`
}

# prompt

#COLOR_dark="\[\e[0;30m\]"
#COLOR_red="\[\e[0;31m\]"
COLOR_green="\[\e[0;32m\]"
COLOR_yellow="\[\e[0;33m\]"
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

PS_CONTEXT='`git get-branch``git get-status`'
PS1="${COLOR_cyan}\u@\h:${COLOR_CYAN}\w ${COLOR_yellow}${PS_CONTEXT}${COLOR_green} >${COLOR_NONE}"

