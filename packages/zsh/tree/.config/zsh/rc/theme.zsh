#!/bin/zsh

# powerlevel10k theme
zinit light-mode for \
	depth=1 romkatv/powerlevel10k

# pure theme
# zinit for \
# compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh' sindresorhus/pure

# window title
precmd() {
	vcs_info
	print -Pn "\e]0; %~\a"
}
preexec() {
	print -Pn "\e]0;%~ $1\a"
}

# source p10k
if [[ -f "$ZSH_CONFIG/p10k.zsh" ]]; then
	source "$ZSH_CONFIG/p10k.zsh"
fi
