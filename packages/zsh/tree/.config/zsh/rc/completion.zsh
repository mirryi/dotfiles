#!/bin/zsh

# Preview command line arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"

# fzf-tab draws the menu itself
zstyle ':completion:*' menu no

# compinit's dump sources ~30ms faster compiled; refresh it when it goes stale
_zcompdump="${XDG_CACHE_HOME}/zsh/compdump"
[[ -s $_zcompdump && ! $_zcompdump.zwc -nt $_zcompdump ]] && zcompile -R -- "$_zcompdump"
unset _zcompdump
