#!/bin/bash
echo "# This will build your new home!"
echo ""

DIR="$( cd "$( dirname "$0" )" && pwd )"
DIR=`dirname $DIR`

##################################
#  check for installed packages  #
##################################

ask_install () {
    echo "-> Do you want me to install $1?"
    select yn in yes no
    do
        if [ -z $yn ]; then
            echo "invalid option"
        elif [ "$yn" == "yes" ]; then
            INSTALL="$INSTALL $1"
            break
        elif [ "$yn" == "no" ]; then
            break
        fi
    done
}

INSTALL=""
if [ ! `command -v git` ]; then
    GIT=false
    ask_install "git"
fi
if [ ! `command -v vim` ]; then
    VIM=false
    ask_install "vim"
fi
if [ ! `command -v tmux` ]; then
    TMUX=false
    ask_install "tmux"
fi

if [ "$INSTALL" != "" ]; then
    echo "-> Installing ${INSTALL}"
    sudo apt-get install ${INSTALL}    
fi

if [ `command -v git` ]; then
    GIT=true
fi
if [ `command -v vim` ]; then
    VIM=true
fi
if [ `command -v tmux` ]; then
    TMUX=true
fi

#######################
#  updating dotfiles  #
#######################
if [ "$GIT" = true ]; then
    echo "-> updating dotfiles"
    cd $DIR
    git pull
fi

echo "-> Install Home or Work environment?"
select myenv in home work
do
    if [ -z $myenv ]; then
        echo "invalid option"
    else
        echo "export ENVIRONMENT=$myenv" > ${HOME}/.bash_customvars
        break
    fi
done

echo "-> We are working on"
case "$(uname -s)" in
   Darwin)
     echo 'Mac OS X'
     ;;
   Linux)
     echo 'Linux'
     echo "$DIR/bin/screenfetch" >> ${HOME}/.bash_customvars
     ;;
   CYGWIN*|MINGW32*|MSYS*)
     echo 'MS Windows'
     echo "$DIR/bin/screeny" >> ${HOME}/.bash_customvars
     ;;
   # Add here more strings to compare
   *)
     echo 'other OS' 
     ;;
esac

#############################
#  backup and link .bashrc  #
#############################
BASHRC="${DIR}/.bashrc"
if [ -f ${HOME}/.bashrc ]; then
    if [ ! `readlink -f ${HOME}/.bashrc` = $BASHRC ]; then
        echo "-> move ${HOME}/.bashrc to ${HOME}/.bashrc_bak"
        mv ${HOME}/.bashrc ${HOME}/.bashrc_bak
        echo "-> link $BASHRC to ${HOME}/.bashrc"
        ln -s $BASHRC ${HOME}/.bashrc
    fi
else
    echo "-> link $BASHRC to ${HOME}/.bashrc"
    ln -s $BASHRC ${HOME}/.bashrc
fi

source ${HOME}/.bashrc

########################################
#  create and populate .vim directory  #
########################################
if [ ! -d ${HOME}/.vim ]; then
    echo "-> creating ${HOME}/.vim"
    mkdir ${HOME}/.vim
fi
if [ ! -d ${HOME}/.vim/bundle ]; then
    echo "-> creating ${HOME}/.vim/bundle"
    mkdir ${HOME}/.vim/bundle
fi
# clone or update Vundle.vim
if [ "$GIT" = true ]; then
    if [ ! -d ${HOME}/.vim/bundle/Vundle.vim ]; then
        echo "-> cloning https://github.com/VundleVim/Vundle.vim.git"
        git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
    else
        echo "-> updating Vundle.vim"
        cd ${HOME}/.vim/bundle/Vundle.vim
        git pull
    fi
fi
MYSNIPPETS="${DIR}/.vim/mysnippets"
if [ -d ${HOME}/.vim/mysnippets ]; then
    if [ ! `readlink -f ${HOME}/.vim/mysnippets` = $MYSNIPPETS ]; then
        echo "-> move ${HOME}/.vim/mysnippets to ${HOME}/.vim/mysnippets_bak"
        mv ${HOME}/.vim/mysnippets ${HOME}/.vim/mysnippets_bak
        echo "-> link $MYSNIPPETS to ${HOME}/.vim/mysnippets"
        ln -s $MYSNIPPETS ${HOME}/.vim/
    fi
else
    echo "-> link $MYSNIPPETS to ${HOME}/.vim/mysnippets"
    ln -s $MYSNIPPETS ${HOME}/.vim/
fi

############################
#  backup and link .vimrc  #
############################
VIMRC="${DIR}/.vimrc"
if [ -f ${HOME}/.vimrc ]; then
    if [ ! `readlink -f ${HOME}/.vimrc` = $VIMRC ]; then
        echo "-> move ${HOME}/.vimrc to ${HOME}/.vimrc_bak"
        mv ${HOME}/.vimrc ${HOME}/.vimrc_bak
        echo "-> link $VIMRC to ${HOME}/.vimrc"
        ln -s $VIMRC ${HOME}/.vimrc
    fi
else
    echo "-> link $VIMRC to ${HOME}/.vimrc"
    ln -s $VIMRC ${HOME}/.vimrc
fi

if [ "$GIT" = false ]; then
    echo "!!! git is not installed! I could not install Vundle.vim and other vim plugins for you! Please do this after installing git by running these commands:"
    echo "git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim"
    echo "vim -E -c 'PluginInstall' -c 'qa!' 2>/dev/null"
else
    echo "-> installing vim Plugins"
    vim -E -c 'PluginInstall' -c 'qa!' 2>/dev/null
fi

#################################
#  backup and link tmux config  #
#################################
if [ "$TMUX" = true ]; then
    TMUXRC="${DIR}/.tmux.conf"
    if [ -f ${HOME}/.tmux.conf ]; then
        if [ ! `readlink -f ${HOME}/.tmux.conf` = $TMUXRC ]; then
            echo "-> move ${HOME}/.tmux.conf to ${HOME}/.tmux.conf_bak"
            mv ${HOME}/.tmux.conf ${HOME}/.tmux.conf_bak
            echo "-> link $TMUXRC to ${HOME}/.tmux.conf"
            ln -s $TMUXRC ${HOME}/.tmux.conf
        fi
    else
        echo "-> link $TMUXRC to ${HOME}/.tmux.conf"
        ln -s $TMUXRC ${HOME}/.tmux.conf
    fi

    echo "-> Please select tmux color scheme"
    select tmuxcolor in blue cyan gray green magenta orange red yellow
    do
        if [ -z $tmuxcolor ]; then
            echo "invalid option"
        else
            echo "source-file \"$DIR/tmux-themes/${tmuxcolor}.tmuxtheme\"" > ${HOME}/.tmux_theme
            break
        fi
    done
fi

echo ""
echo "# Finished! Have fun!"
