#
# User configuration sourced by interactive shells
#
export TERM="xterm-256color"
export EDITOR='vim'

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward
KEYTIMEOUT=1

# Use ctrl-z to get bg task to fg
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# add tab completion for ssh/config
h=()
if [[ -r ~/.ssh/config ]]; then
    h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ $#h -gt 0 ]]; then
    zstyle ':completion:*:ssh:*' hosts $h
    zstyle ':completion:*:slogin:*' hosts $h
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin/ctags/bin:$HOME/bin/vim/bin:$HOME/bin:/usr/local/go/bin:/cygdrive/c/Go/bin:$PATH
alias vi='vim'

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
