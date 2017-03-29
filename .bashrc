# .bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export PATH=$PATH:~/bin

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
umask 022

export PS1="\[\e[32m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\] | \[\e[35m\]\t\[\e[m\] | \[\e[36m\]\w\[\e[m\] \\$ "
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

if [ `command -v tmux` ] && [ -z "$TMUX" ]; then
    if [ "$SSH_CONNECTION" != "" ]; then
        ( tmux -2 attach-session -t ssh || tmux -2 new-session -s ssh ) && exit
    else
        tmux -2 new-session && exit
    fi
else
    source ~/.sh_customvars

    if [ `command -v task` ]; then
        alias ta='task'
        alias ts='task pro:work'
        alias th='task pro:home'
        alias t='task pro:$ENVIRONMENT'
    fi
    if [ `command -v timew` ]; then
        alias tw='timew'
        alias tws='timew summary'
        alias tww='timew summary :week'
        alias tt='timew track'
    fi
fi
