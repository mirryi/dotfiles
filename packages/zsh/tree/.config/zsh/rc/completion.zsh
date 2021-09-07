#!/bin/zsh

# auto pairs
zinit wait'2' lucid light-mode for \
  hlissner/zsh-autopair

# OMZ git
zinit wait'1' lucid has'git' light-mode for \
  OMZ::lib/git.zsh \
  OMZ::plugins/git/git.plugin.zsh

# autosuggestions, more completions
zinit wait lucid light-mode for \
  atload'!_zsh_autosuggest_start' zsh-users/zsh-autosuggestions \
  blockf zsh-users/zsh-completions

zinit wait lucid light-mode for \
  gentoo/gentoo-zsh-completions

# syntax highlighting
zinit light-mode for \
  atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' zdharma/fast-syntax-highlighting

# autocomplete
zinit light-mode for \
  marlonrichert/zsh-autocomplete
zstyle ':autocomplete:*' min-delay 0.3
zstyle ':autocomplete:*' min-input 2
zstyle ':autocomplete:*' list-lines 10
zstyle ':autocomplete:*' recent-dirs zoxide
zstyle ':autocomplete:*' widget-style menu-complete

if [[ -d "${ZSH_DATA}/completions" ]]; then
  zinit creinstall -Q "${ZSH_DATA}/completions"
fi

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"

# misc completion menu settings
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:default' menu yes select search
