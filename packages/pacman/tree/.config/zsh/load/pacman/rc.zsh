#!/bin/zsh
# suggest packages providing an unknown command
[[ ! -f /usr/share/doc/pkgfile/command-not-found.zsh ]] ||
	. /usr/share/doc/pkgfile/command-not-found.zsh

# pacman completion settings
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
zstyle ':fzf-tab:complete:pacman:*' fzf-preview 'pacman -Qi $realpath'
