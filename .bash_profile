# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTCONTROL=ignorespaces:erasedups
export HISTFILESIZE=1000
export GPG_TTY=‘tty‘

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias r='fc -s'

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


#system helpers
#note .bashrc for ubuntu .bash_profile for osx
alias vib='vi ~/.bash_profile'
alias b.='. ~/.bash_profile'
alias nocaps='setxkbmap -option ctrl:nocaps'
alias auto='nice -7 xterm -e script/autospec &'


#profile for git completion?


source ~/.git-completion.bash


# -*- mode: sh; -*-
#############################################################################
#
# Filename: bashrc.local
# Author: Chris Charles
#
# ---------------------------------------------------------------------------
#
# Local settings for Bash.
#
#############################################################################
 

# Function to read the current Subversion revision.
#
# Inspired by the __git_ps1 function provided by Git's bash completion.
__svn_ps1() {
    if $(svn info >/dev/null 2>&1); then
        local revision=$(svn info | grep Revision | awk '{print $2}')
        echo -n "svn:$revision"
 
        local status=$(svn status)
        if [ "$status" != "" ]; then
            echo "*";
        fi
    fi
}
 
# Update the prompts.

awesome_prompt() {
    local EXIT_STATUS="$?"
    if type -t __git_ps1 | grep -q "function"; then
        local GIT_BRANCH=$(__git_ps1 "git:%s")
    fi
    local SVN_STATUS=$(__svn_ps1)

    PS1="\[\e[94m\]\u\[\e[0m\] \[\e[92m\]\h \[\e[93m\]\w\[\e[90m\]"
    PS2="\[\e[90m\]... \[\e[0m\]"

    if [ "$GIT_BRANCH" != '' ]; then
        PS1="$PS1 \[\e[96m\]$GIT_BRANCH"
    fi

    if [ "$SVN_STATUS" != '' ]; then
        PS1="$PS1 \[\e[96m\]$SVN_STATUS"
    fi

    if [ "$EXIT_STATUS" -eq "0" ]; then
        PS1="$PS1 \[\e[90m\]"
    else
        PS1="$PS1 \[\e[91m\]";
    fi

    PS1="$PS1($EXIT_STATUS)\[\e[0m\]\n\[\e[90m\]> \[\e[0m\]"
}

export PROMPT_COMMAND=awesome_prompt


##
# Your previous /Users/admin/.bash_profile file was backed up as /Users/admin/.bash_profile.macports-saved_2011-04-06_at_15:41:49
##

# MacPorts Installer addition on 2011-04-06_at_15:41:49: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

