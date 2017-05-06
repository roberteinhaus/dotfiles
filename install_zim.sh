#!/bin/zsh
setopt EXTENDED_GLOB
for template_file ( ${ZDOTDIR:-${HOME}}/.zim/templates/{zimrc,zlogin} ); do
    user_file="${ZDOTDIR:-${HOME}}/.${template_file:t}"
    touch ${user_file}
    ( print -rn "$(<${template_file})$(<${user_file})" >! ${user_file} ) 2>/dev/null
done
