# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTCONTROL=ignorespaces:erasedups
export HISTFILESIZE=1000
export GPG_TTY=‘tty‘

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
#    ;;
#*)
#    ;;
#esac


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#for osx
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

#for ubuntu
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi

# External dotfiles
source ~/dotfiles/bash-aliases.sh
source ~/dotfiles/git-completion.sh
source ~/dotfiles/bash-prompt.sh
source ~/dotfiles/bash-colour.sh
source ~/dotfiles/bash-macports.sh
