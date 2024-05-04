#!/bin/bash


# Steps for using this:
# 1. Rename this script to ".bashrc_custominit"
# 2. ADD `. ~/.bashrc_custominit` to ".bashrc" file


# USE THIS: http://bashrcgenerator.com/
# It is the best


### PS1 TEXTS ###
text_time='\t'
text_user='\u'
text_host='\h'
text_fullPath='\w'
text_currDir='\W'


parse_git_branch(){
    command -v git >/dev/null 2>&1 || return
    # git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' | sed -e 's/master/M/g'
    branch_name=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ -z "${branch_name}" ]; then
        echo -en ""
    else
        echo -en "\[$(tput bold)\]\[\033[33m\]✗\[$(tput sgr0)\]\[$(tput bold)\]\[\033[01;34m\] git:(\[$(tput sgr0)\]\[\033[38;5;9m\]${branch_name}\[$(tput sgr0)\]\[$(tput bold)\]\[\033[01;34m\])\[$(tput sgr0)\]"
        # echo -en "${py_attr_bold}${py_yellow}✗${py_blue} git:(${py_red}${branch_name}${py_blue})"
    fi
}

parse_exit_code(){
    if [ ${1} -eq "0" ]; then
        echo -en "\[$(tput bold)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\]"
    else
        echo -en "\[$(tput bold)\]\[\033[38;5;9m\]\\$\[$(tput sgr0)\]"
    fi
}

__prompt_command(){
    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    [[ -v "CONDA_DEFAULT_ENV" ]] && conda_env_name="($CONDA_DEFAULT_ENV) " || conda_env_name=""
    EXIT_VAL="$?"
    if [ "`id -u`" -eq 0 ]; then
        # root user
        export PS1="${conda_env_name}${debian_chroot}\[$(tput bold)\]\[\033[38;5;9m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;39m\]\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[01;34m\]\w\[$(tput sgr0)\]$(parse_git_branch)$(parse_exit_code ${EXIT_VAL}) \[$(tput sgr0)\]"
    else
        # normal user
        # can add time at the start
        export PS1="${conda_env_name}${debian_chroot}\[$(tput bold)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;39m\]\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[01;34m\]\w\[$(tput sgr0)\]$(parse_git_branch)$(parse_exit_code ${EXIT_VAL}) \[$(tput sgr0)\]"
    fi
}

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

# ➜
# ✗

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# REFER: https://stackoverflow.com/questions/5367068/clear-a-terminal-screen-for-real
alias cls='clear && echo -en "\e[3J"'   # work with bash, zsh, tmux, KDE
# alias cls='printf "\033c"'            # not tested

which tmux && alias tmux="tmux -u"


