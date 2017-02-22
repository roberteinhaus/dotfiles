#!/bin/sh
echo "# This will build your new home!"
echo ""

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR=`dirname $DIR`

if [ `command -v git` ]; then
    GIT=true
else
    GIT=false
fi

#######################
#  updating dotfiles  #
#######################
if [ $GIT = true ]; then
    echo "-> updating dotfiles"
    cd $DIR
    git pull
fi


#############################
#  backup and link .bashrc  #
#############################
BASHRC="${DIR}/.bashrc"
if [ -f ~/.bashrc ]; then
    if [ ! `readlink -f ~/.bashrc` = $BASHRC ]; then
        echo "-> move ~/.bashrc to ~/.bashrc_bak"
        mv ~/.bashrc ~/.bashrc_bak
        echo "-> link $BASHRC to ~/.bashrc"
        ln -s $BASHRC ~/.bashrc
    fi
else
    echo "-> link $BASHRC to ~/.bashrc"
    ln -s $BASHRC ~/.bashrc
fi

########################################
#  create and populate .vim directory  #
########################################
if [ ! -d ~/.vim ]; then
    echo "-> creating ~/.vim"
    mkdir ~/.vim
fi
if [ ! -d ~/.vim/bundle ]; then
    echo "-> creating ~/.vim/bundle"
    mkdir ~/.vim/bundle
fi
# clone or update Vundle.vim
if [ $GIT = true ]; then
    if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
        echo "-> cloning https://github.com/VundleVim/Vundle.vim.git"
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    else
        echo "-> updating Vundle.vim"
        cd ~/.vim/bundle/Vundle.vim
        git pull
    fi
fi
MYSNIPPETS="${DIR}/.vim/mysnippets"
if [ -d ~/.vim/mysnippets ]; then
    if [ ! `readlink -f ~/.vim/mysnippets` = $MYSNIPPETS ]; then
        echo "-> move ~/.vim/mysnippets to ~/.vim/mysnippets_bak"
        mv ~/.vim/mysnippets ~/.vim/mysnippets_bak
        echo "-> link $MYSNIPPETS to ~/.vim/mysnippets"
        ln -s $MYSNIPPETS ~/.vim/
    fi
else
    echo "-> link $MYSNIPPETS to ~/.vim/mysnippets"
    ln -s $MYSNIPPETS ~/.vim/
fi

############################
#  backup and link .vimrc  #
############################
VIMRC="${DIR}/.vimrc"
if [ -f ~/.vimrc ]; then
    if [ ! `readlink -f ~/.vimrc` = $VIMRC ]; then
        echo "-> move ~/.vimrc to ~/.vimrc_bak"
        mv ~/.vimrc ~/.vimrc_bak
        echo "-> link $VIMRC to ~/.vimrc"
        ln -s $VIMRC ~/.vimrc
    fi
else
    echo "-> link $VIMRC to ~/.vimrc"
    ln -s $VIMRC ~/.vimrc
fi

if [ $GIT = false ]; then
    echo "!!! git is not installed! I could not install Vundle.vim and other vim plugins for you! Please do this after installing git by running these commands:"
    echo "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
    echo "vim -E -c 'PluginInstall' -c 'qa!' 2>/dev/null"
else
    echo "-> installing vim Plugins"
    vim -E -c 'PluginInstall' -c 'qa!' 2>/dev/null
fi

echo ""
echo "# Finished! Have fun!"
