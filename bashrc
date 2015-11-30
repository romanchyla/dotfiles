#!/bin/bash
#
# Mitchell Hashimoto's bash environment
# Much taken from Ryan Tomayko (thanks!)

# Basics
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# Complete hostnames from this file
: ${HOSTFILE=~/.ssh/known_hosts}

#-------------------------------------------------------------------------------
# Shell Options
#-------------------------------------------------------------------------------

# System bashrc
test -r /etc/bash.bashrc && . /etc/bash.bashrc

# Notify bg task completion immediately
set -o notify

# Fucking mail notifications
unset MAILCHECK

# default umask
umask 0022

# Terminal type
case $UNAME in
    CYGWIN* | MINGW32*)
        export TERM=cygwin
        ;;
    *)
        export TERM=xterm-256color
        ;;
esac

#-------------------------------------------------------------------------------
# Path
#-------------------------------------------------------------------------------

case $UNAME in
    MINGW32*)
        # Don't touch the default PATH, it inherits Windows.
        ;;
    *)
        # Various sbins
        PATH="/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin"
        PATH="/usr/local/bin:$PATH"
        ;;
esac

# OS-Specific path stuff
if [[ `uname` == "Darwin" ]]; then
    alias emacs="/usr/local/Cellar/emacs/23.3/Emacs.app/Contents/MacOS/Emacs -nw"
elif [[ `uname` == "Linux" ]]; then
    PATH="/usr/bin/perlbin/vendor:$PATH"
fi

# ~/bin if it exists
test -d "$HOME/bin" &&
PATH="$HOME/bin:$PATH"

# texbin if it exists for LaTeX stuff
test -d "/usr/texbin" &&
PATH="/usr/texbin:$PATH"

# Heroku toolbelt
test -d "/usr/local/heroku/bin" &&
PATH="/usr/local/heroku/bin:$PATH"

#-------------------------------------------------------------------------------
# Env. Configuration
#-------------------------------------------------------------------------------

# detect interactive shell
case "$-" in
    *i*) INTERACTIVE=yes ;;
    *)   unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
    -*) LOGIN=yes ;;
    *)  unset LOGIN ;;
esac

# Proper locale
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# Always use passive mode FTP
: ${FTP_PASSIVE:=1}
export FTP_PASSIVE

# Ignore backups, CVS directories
FIGNORE="~:CVS:#:.pyc"
HISTCONTROL=ignoredups:ignorespace
# append to the history file, don't overwrite it
shopt -s histappend
# reedit a history substitution line if it failed
shopt -s histreedit
# edit a recalled hisotry line before executing
shopt -s histverify
HISTSIZE=1000
HISTFILESIZE=2000

# check window size after each command and update if
# necessary (values of LINES and COLUMNS)
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# XDG config
export XDG_CONFIG_HOME="$HOME"

#-------------------------------------------------------------------------------
# Editor and Pager
#-------------------------------------------------------------------------------
EDITOR="vim"
export EDITOR

PAGER="less -FirSwX"
MANPAGER="$PAGER"
export PAGER MANPAGER

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------
RED="\[\033[0;31m\]"
BROWN="\[\033[0;33m\]"
GREY="\[\033[0;97m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
PS_CLEAR="\[\033[0m\]"
SCREEN_ESC="\[\033k\033\134\]"

COLOR1="${BLUE}"
COLOR2="${BLUE}"
P="\$"

prompt_simple() {
    unset PROMPT_COMMAND
    PS1="\W\$(parse_git_branch) → "
    PS2="> "
}

prompt_compact() {
    unset PROMPT_COMMAND
    PS1="${COLOR1}${P}${PS_CLEAR} "
    PS2="> "
}

prompt_color() {
    PS1="${GREEN}\W\$(parse_git_branch) → ${GREY}"
    PS2="\[[33;1m\]continue \[[0m[1m\]> "
}

parse_git_branch() {
    [ -d .git ] || return 1
    git symbolic-ref HEAD 2> /dev/null | sed 's#\(.*\)\/\([^\/]*\)$# \2#'
}

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#-------------------------------------------------------------------------------
# Aliases / Functions
#-------------------------------------------------------------------------------
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases.secret ]; then
    . ~/.bash_aliases.secret
fi


# Usage: puniq [path]
# Remove duplicate entries from a PATH style value while
# retaining the original order.
puniq() {
    echo "$1" |tr : '\n' |nl |sort -u -k 2,2 |sort -n |
    cut -f 2- |tr '\n' : |sed -e 's/:$//' -e 's/^://'
}

#-------------------------------------------------------------------------------
# SSH Agent
#-------------------------------------------------------------------------------
SSH_ENV=$HOME/.ssh/environment

function start_ssh_agent {
     ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
     chmod 0600 ${SSH_ENV}
     . ${SSH_ENV} > /dev/null
     ssh-add
}

# Source SSH agent settings if it is already running, otherwise start
# up the agent proprely.
if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     # ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_ssh_agent
     }
else
     start_ssh_agent
fi

#-------------------------------------------------------------------------------
# Other
#-------------------------------------------------------------------------------
# Plugins
PLUGINS=( "depot_tools" "git" "java" "tmux" "windows" )

for plugin in "${PLUGINS[@]}"
do
  plugin_path="$HOME/.bash.d/${plugin}"
  test -f $plugin_path && source $plugin_path
done

#-------------------------------------------------------------------------------
# User Shell Environment
#-------------------------------------------------------------------------------
case $UNAME in
    MINGW32*)
        # Don't condense path, since function doesn't work here.
        ;;
    *)
        # Condense path variables
        PATH=$(puniq $PATH)
        MANPATH=$(puniq $MANPATH)
        ;;
esac

# Set default prompt if interactive
test -n "$PS1" &&
prompt_color

if [ -f "$HOME/.rvm/scripts/rvm" ]; then
    source $HOME/.rvm/scripts/rvm
fi

# Always put /usr/local/bin first.
case $UNAME in
    MINGW32*)
        ;;
    *)
        # Various sbins
        PATH="/usr/local/bin:/usr/bin:$PATH"
        ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# prevent ctrl-d logouts
export ignoreeof=3

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
unset MANPATH # for for .fzf

[ -f ~/.localenv ] && source ~/.localenv
