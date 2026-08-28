#!/bin/zsh

# Preview command line arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"

# colour the completion list like ls
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# show a selectable menu instead of cycling silently; zsh-autocomplete sets
# 'menu no no-select' on this exact context, so match it to override
zstyle ':completion:*:*:*:*:default' menu yes select search

# Limit number of completion results
zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 3 )) )'

# Require minimum input
zstyle ':autocomplete:*' min-input 3

# compinit's dump sources ~30ms faster compiled; refresh it when it goes stale
_zcompdump="${XDG_CACHE_HOME}/zsh/compdump"
[[ -s $_zcompdump && ! $_zcompdump.zwc -nt $_zcompdump ]] && zcompile -R -- "$_zcompdump"
unset _zcompdump

# builtin widgets; zsh-autocomplete's same-named wrappers re-insert match 1 every press
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" .reverse-menu-complete
bindkey -- '^I' .menu-complete
