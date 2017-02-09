#############################################################################
#
# Filename: bashrc.local
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

RED='\[\033[31m\]'

# Update the prompts.
awesome_prompt() {
    local EXIT_STATUS="$?"
    if type -t __git_ps1 | grep -q "function"; then
        local GIT_BRANCH=$(__git_ps1 "git:%s")
    fi
    local SVN_STATUS=$(__svn_ps1)

    PS1="\[\e[94m\]\u\[\e[0m\] \[\e[92m\]\h \[\e[93m\]\w\[\e[90m\]"
    PS2="\[\e[90m\]... \[\e[0m\]"

    if [[ $VIRTUAL_ENV != "" ]]
        then
          # Strip out the path and just leave the env name
          venv=" ${RED}(${VIRTUAL_ENV##*/})"
    else
          # In case you don't have one activated
          venv=''
    fi
    PS1="$PS1 \[\033[39m\]$venv"

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
