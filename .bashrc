# $HOME/.bashrc file for bash-4.0 or later
# Author: Starfleetcadet75 <starfleetcadet75@gmail.com>
# Last modified: 01Jun2015

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# changes the prompt text
export PS1="star> "

#starts tmux with the terminal
[ -z "$TMUX" ] && exec tmux -2

# fixes spelling
shopt -s cdspell
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# type completion for git commands
[ -f /etc/bash_completion.d/git ] && . /etc/bash_completion.d/git

# creates alias definitions from ~/.bash_aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

