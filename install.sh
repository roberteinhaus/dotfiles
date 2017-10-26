#!/bin/bash
echo "# This will build your new home!"
echo ""

DIR="$( cd "$( dirname "$0" )" && pwd )"

##################################
#  check for installed packages  #
##################################

ask_install () {
    if [ `command -v apt-get` ]; then
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
    fi
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
if [ ! `command -v zsh` ]; then
    ZSH_INSTALLED=false
    ask_install "zsh"
fi
if [ ! `command -v fish` ]; then
    FISH_INSTALLED=false
    ask_install "fish"
fi
if [ ! `command -v curl` ]; then
    CURL_INSTALLED=false
    ask_install "curl"
fi
if [ ! `command -v ctags` ]; then
    CTAGS=false
    ask_install "exuberant-ctags"
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
if [ `command -v zsh` ]; then
    ZSH_INSTALLED=true
fi
if [ `command -v fish` ]; then
    FISH_INSTALLED=true
fi
if [ `command -v curl` ]; then
    CURL_INSTALLED=true
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
        echo "export ENVIRONMENT=$myenv" > ${HOME}/.sh_customvars
        break
    fi
done

echo "-> We are working on"
case "$(uname -s)" in
    Darwin)
        echo 'Mac OS X'
        CUROS="MACOS"
        ;;
    Linux)
        echo 'Linux'
        $DIR/bin/screenfetch_static > ${HOME}/.screenfetch
        echo "cat ${HOME}/.screenfetch" >> ${HOME}/.sh_customvars
        CUROS="LINUX"
        ;;
    CYGWIN*|MINGW32*|MSYS*)
        echo 'MS Windows'
        $DIR/bin/screenfetch_static > ${HOME}/.screenfetch
        echo "cat ${HOME}/.screenfetch" >> ${HOME}/.sh_customvars
        CUROS="WIN"
        ;;
    *)
        echo 'other OS'
        CUROS="OTHER"
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

###########################
#  install omz zshrc  #
###########################
if [ "$ZSH_INSTALLED" = true ]; then
    if [ `command -v git` ]; then
        echo "-> installing OMZ"
        git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh --depth 1
        git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k
    fi
    ZSHRC="${DIR}/.zshrc"
    if [ -f ${HOME}/.zshrc ]; then
        if [ ! `readlink -f ${HOME}/.zshrc` = $ZSHRC ]; then
            echo "-> move ${HOME}/.zshrc to ${HOME}/.zshrc_bak"
            mv ${HOME}/.zshrc ${HOME}/.zshrc_bak
            echo "-> link $ZSHRC to ${HOME}/.zshrc"
            ln -s $ZSHRC ${HOME}/.zshrc
        fi
    else
        echo "-> link $ZSHRC to ${HOME}/.zshrc"
        ln -s $ZSHRC ${HOME}/.zshrc
    fi
fi


#######################################
#  install fisherman and config.fish  #
#######################################
if [ "$FISH_INSTALLED" = true ]; then
    # install fisherman
    if [ "$CURL_INSTALLED" = true ]; then
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
	fish -c 'fisher z oh-my-fish/theme-bobthefish'
    fi
    if [ ! -d ${HOME}/.config ]; then
        echo "-> creating ${HOME}/.config"
        mkdir ${HOME}/.config
    fi
    if [ ! -d ${HOME}/.config/fish ]; then
        echo "-> creating ${HOME}/.config/fish"
        mkdir ${HOME}/.config/fish
    fi
    if [ ! -d ${HOME}/.config/fish/functions ]; then
        echo "-> creating ${HOME}/.config/fish/functions"
        mkdir ${HOME}/.config/fish/functions
    fi
    FISHRC="${DIR}/fish/config.fish"
    FISHCONFIG="${HOME}/.config/fish/config.fish"
    if [ -f ${FISHCONFIG} ]; then
        if [ ! `readlink -f ${FISHCONFIG}` = $FISHRC ]; then
            echo "-> move ${FISHCONFIG} to ${HOME}/.fishrc_bak"
            mv ${FISHCONFIG} ${HOME}/.fishrc_bak
            echo "-> link $FISHRC to ${HOME}/.fishrc"
            ln -s $FISHRC ${FISHCONFIG}
        fi
    else
        echo "-> link $FISHRC to ${FISHCONFIG}"
        ln -s $FISHRC ${FISHCONFIG}
    fi
    FISHKEYS="${DIR}/fish/functions/fish_user_key_bindings.fish"
    FISHKEYSCONFIG="${HOME}/.config/fish/functions/fish_user_key_bindings.fish"
    if [ -f ${FISHKEYSCONFIG} ]; then
        if [ ! `readlink -f ${FISHKEYSCONFIG}` = $FISHKEYS ]; then
            echo "-> move ${FISHKEYSCONFIG} to ${HOME}/.fishrc_bak"
            mv ${FISHKEYSCONFIG} ${HOME}/.fishrc_bak
            echo "-> link $FISHKEYS to ${HOME}/.fishrc"
            ln -s $FISHKEYS ${FISHKEYSCONFIG}
        fi
    else
        echo "-> link $FISHKEYS to ${FISHKEYSCONFIG}"
        ln -s $FISHKEYS ${FISHKEYSCONFIG}
    fi
fi

###########################################################
#  backup and link .minttyrc and copy /etc/nsswitch.conf  #
###########################################################
if [ "$CUROS" = "WIN" ]; then
    MINTTYRC="${DIR}/.minttyrc"
    if [ -f ${HOME}/.minttyrc ]; then
        if [ ! `readlink -f ${HOME}/.minttyrc` = $MINTTYRC ]; then
            echo "-> move ${HOME}/.minttyrc to ${HOME}/.minttyrc_bak"
            mv ${HOME}/.minttyrc ${HOME}/.minttyrc_bak
            echo "-> link $MINTTYRC to ${HOME}/.minttyrc"
            ln -s $MINTTYRC ${HOME}/.minttyrc
        fi
    else
        echo "-> link $MINTTYRC to ${HOME}/.minttyrc"
        ln -s $MINTTYRC ${HOME}/.minttyrc
    fi
    NSSWITCH="${DIR}/etc/nsswitch.conf"
    if [ -f /etc/nsswitch.conf ]; then
        if [ ! `readlink -f /etc/nsswitch.conf` = $NSSWITCH ]; then
            echo "-> move /etc/nsswitch.conf to /etc/nsswitch.conf_bak"
            mv /etc/nsswitch.conf /etc/nsswitch.conf_bak
            echo "-> copy $NSSWITCH to /etc/nsswitch.conf"
            cp $NSSWITCH /etc/nsswitch.conf
        fi
    else
        echo "-> copy $NSSWITCH to /etc/nsswitch.conf"
        cp $NSSWITCH /etc/nsswitch.conf
    fi
fi

#####################
# install spf13 vim #
#####################
if [ "$VIM" = true ]; then
    VIMRC="${DIR}/.vimrc.before.local"
    VIMCONFIG="${HOME}/.vimrc.before.local"
    if [ -f ${VIMCONFIG} ]; then
        if [ ! `readlink -f ${VIMCONFIG}` = $VIMRC ]; then
            echo "-> move ${VIMCONFIG} to ${HOME}/.vimrc.before.local_bak"
            mv ${VIMCONFIG} ${HOME}/.vimrc.before.local_bak
            echo "-> link $VIMRC to ${HOME}/.vimrc.before.local"
            ln -s $VIMRC ${VIMCONFIG}
        fi
    else
        echo "-> link $VIMRC to ${VIMCONFIG}"
        ln -s $VIMRC ${VIMCONFIG}
    fi
    # install spf13
    if [ "$CURL_INSTALLED" = true ]; then
        curl http://j.mp/spf13-vim3 -L -o - | sh
    fi
fi

########################################
#  create and populate .vim directory  #
########################################
#if [ ! -d ${HOME}/.vim ]; then
    #echo "-> creating ${HOME}/.vim"
    #mkdir ${HOME}/.vim
#fi
#if [ ! -d ${HOME}/.vim/bundle ]; then
    #echo "-> creating ${HOME}/.vim/bundle"
    #mkdir ${HOME}/.vim/bundle
#fi
## install vim-plug
#if [ "$CURL_INSTALLED" = true ]; then
    #curl -fLo  ${HOME}/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#fi
#MYSNIPPETS="${DIR}/.vim/mysnippets"
#if [ -d ${HOME}/.vim/mysnippets ]; then
    #if [ ! `readlink -f ${HOME}/.vim/mysnippets` = $MYSNIPPETS ]; then
        #echo "-> move ${HOME}/.vim/mysnippets to ${HOME}/.vim/mysnippets_bak"
        #mv ${HOME}/.vim/mysnippets ${HOME}/.vim/mysnippets_bak
        #echo "-> link $MYSNIPPETS to ${HOME}/.vim/mysnippets"
        #ln -s $MYSNIPPETS ${HOME}/.vim/
    #fi
#else
    #echo "-> link $MYSNIPPETS to ${HOME}/.vim/mysnippets"
    #ln -s $MYSNIPPETS ${HOME}/.vim/
#fi
#if [ ! -d ${HOME}/.vim/undo ]; then
    #echo "-> creating ${HOME}/.vim/undo"
    #mkdir ${HOME}/.vim/undo
#fi

############################
#  backup and link .vimrc  #
############################
#VIMRC="${DIR}/.vimrc"
#if [ -f ${HOME}/.vimrc ]; then
    #if [ ! `readlink -f ${HOME}/.vimrc` = $VIMRC ]; then
        #echo "-> move ${HOME}/.vimrc to ${HOME}/.vimrc_bak"
        #mv ${HOME}/.vimrc ${HOME}/.vimrc_bak
        #echo "-> link $VIMRC to ${HOME}/.vimrc"
        #ln -s $VIMRC ${HOME}/.vimrc
    #fi
#else
    #echo "-> link $VIMRC to ${HOME}/.vimrc"
    #ln -s $VIMRC ${HOME}/.vimrc
#fi
#
#if [ "$GIT" = false ]; then
    #echo "!!! git is not installed! I could not install Vundle.vim and other vim plugins for you! Please do this after installing git by running these commands:"
    #echo "git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim"
    #echo "vim -E -c 'PluginInstall' -c 'qa!' 2>/dev/null"
#else
    #echo "-> installing vim Plugins"
    #vim -E -c 'PlugInstall' -c 'qa!' 2>/dev/null
#fi
#
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
    select tmuxcolor in blue cyan green magenta orange red yellow
    do
        if [ -z $tmuxcolor ]; then
            echo "invalid option"
        else
            echo "source-file \"$DIR/tmux-themes/${tmuxcolor}.tmuxtheme\"" > ${HOME}/.tmux_theme
            echo "source-file \"$DIR/tmux-themes/gray.tmuxtheme\"" > ${HOME}/.tmux_theme_inactive
            break
        fi
    done
fi

########################
#  add local binaries  #
########################
#echo "export PATH=\$PATH:${DIR}/bin" >> ${HOME}/.sh_customvars

echo ""
echo "# Finished! Have fun!"
