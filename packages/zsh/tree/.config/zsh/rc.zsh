#!/bin/zsh

local HERE="$(dirname "${(%):-%N}")"

# Load shared components
source "$HOME/.config/sh/rc"

# Load p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load antidote
source "/usr/share/zsh-antidote/antidote.zsh"
zstyle ':antidote:bundle' file "$HERE/rc/plugins.txt"
zstyle ':antidote:static' file "$HERE/rc/plugins.zsh"
antidote load

# Load p10k
[[ ! -f "$HERE/rc/p10k.zsh" ]] || source "$HERE/rc/p10k.zsh"

# Load core components
. "$HERE/rc/opts.zsh"
. "$HERE/rc/completion.zsh"
. "$HERE/rc/keybindings.zsh"
. "$HERE/rc/macros.zsh"

# zsh-users/zsh-history-substring-search
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=white,bold,underline"
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true

# MichaelAquilina/zsh-autoswitch-virtualenv
export AUTOSWITCH_VIRTUAL_ENV_DIR="${XDG_DATA_HOME}/venvs"

# Tarrasch/zsh-autoenv
export AUTOENV_FILE_ENTER=".autoenv.zsh"
export AUTOENV_FILE_LEAVE=".autoenv.exit.zsh"

# Initialize zoxide
eval "$(zoxide init zsh)"

# Load manual plugins
. "$XDG_CONFIG_HOME/sh/util"
shload "env.zsh" "$XDG_CONFIG_HOME/zsh"
shload "rc.zsh" "$XDG_CONFIG_HOME/zsh"
unsetutil
