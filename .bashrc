# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# source path
# shellcheck source=.config/sh/path
[[ -f "$XDG_CONFIG_HOME/sh/path" ]] && source "$XDG_CONFIG_HOME/sh/path"

# source aliases
# shellcheck source=.config/sh/aliases
[[ -f "$XDG_CONFIG_HOME/sh/aliases" ]] && source "$XDG_CONFIG_HOME/sh/aliases"
