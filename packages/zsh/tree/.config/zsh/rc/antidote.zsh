#!/bin/zsh

# Load antidote
source "/usr/share/zsh-antidote/antidote.zsh"
zstyle ':antidote:bundle' file "$XDG_CONFIG_HOME/zsh/rc/plugins.txt"
zstyle ':antidote:static' file "$XDG_CONFIG_HOME/zsh/rc/plugins.zsh"
antidote load
