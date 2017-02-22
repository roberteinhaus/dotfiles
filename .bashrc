# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
umask 022

export PS1="\[\e[32m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\] | \[\e[35m\]\t\[\e[m\] | \[\e[36m\]\w\[\e[m\] \\$ "
