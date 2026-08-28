#!/bin/zsh

# zsh-autocomplete's own `autoload +X zasync` searches $fpath; without this it
# leaves an unloadable stub behind and all async completion silently dies
fpath=( "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zasync" $fpath )

# Load antidote
source "/usr/share/zsh-antidote/antidote.zsh"
zstyle ':antidote:bundle' file "$XDG_CONFIG_HOME/zsh/rc/plugins.txt"
zstyle ':antidote:static' file "$XDG_CONFIG_HOME/zsh/rc/plugins.zsh"
antidote load
