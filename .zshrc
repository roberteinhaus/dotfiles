#
# User configuration sourced by interactive shells
#
export TERM="xterm-256color"
export EDITOR='vim'

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$PATH

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
if [ `command -v curl` ]; then
    alias wetter='curl -s http://wttr.in/Wallenhorst\?lang\=de | grep -vE "(New|Follow)"'
fi
