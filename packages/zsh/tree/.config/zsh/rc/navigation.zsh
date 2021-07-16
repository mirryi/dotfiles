#!/bin/zsh

# z.lua
# export _ZL_DATA="$ZSH_DATA/.zlua"
# zinit light skywind3000/z.lua

# zoxide
zinit wait lucid has'zoxide' light-mode for \
	atinit'export _ZO_DATA_DIR="$ZSH_DATA/zoxide"' ajeetdsouza/zoxide

# autoswitch-virtualenv
zinit wait'2' lucid has'virtualenv' light-mode for \
	MichaelAquilina/zsh-autoswitch-virtualenv

# autoswitch poetry
zinit wait'2' lucid has'poetry' light-mode for \
	darvid/zsh-poetry

# auto source env files
zinit wait'1' lucid light-mode for \
	atinit'export AUTOENV_FILE_ENTER=".autoenv.zsh"; export AUTOENV_FILE_LEAVE=".autoenv.exit.zsh"' Tarrasch/zsh-autoenv
