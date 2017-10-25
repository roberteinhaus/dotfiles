# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin/vim/bin:$HOME/bin:/home/linuxbrew/.linuxbrew/bin:/usr/lib/go-1.9/bin:/usr/local/go/bin:/cygdrive/c/Go/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode context dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs command_execution_time history time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_with_package_name
POWERLEVEL9K_DIR_SHOW_WRITABLE=true

bindkey '^f' autosuggest-accept

KEYTIMEOUT=1

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(docker git z httpie node npm python sudo vi-mode zsh-autosuggestions)


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'
alias vi='vim'

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
        alias twl='timew summary :lastweek'
        alias tt='timew track'
    fi
fi
if [ `command -v curl` ]; then
    alias wetter='curl -s http://wttr.in/Wallenhorst\?lang\=de | grep -vE "(New|Follow|Neue|Folgen)"'
fi
