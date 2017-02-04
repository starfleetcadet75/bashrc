#!/usr/bin/env bash

export BASH_IT="/home/starfleetcadet75/.bash_it"  # Path to the bash it configuration
export BASH_IT_THEME='hacker'  # Custom theme file from /.bash_it/themes/ 

# starts tmux with the terminal
if [ -e /usr/bin/tmux ]; then
    [ -z "$TMUX" ] && exec tmux -2
fi

source $HOME/Scripts/environment.sh  # Source env variables

# History options
HISTCONTROL=ignoreboth  # don't put duplicate lines or lines starting with space in the history
shopt -s histappend  # append to the history file, don't overwrite it
shopt -s cdspell
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

unset MAILCHECK  # Don't check mail when opening terminal.

# Added by travis gem
[ -f /home/starfleetcadet75/.travis/travis.sh ] && source /home/starfleetcadet75/.travis/travis.sh

export IRC_CLIENT='weechat'  # Console IRC client

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
source $BASH_IT/bash_it.sh
