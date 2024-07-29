# GPG password prompt
export GPG_TTY=$(tty)

# open tmux by default
[[ $TERM != "tmux-256color" ]] && exec tmux

# Load shared components
source "$HOME/.config/sh/rc"

# Load p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load antidote
source "/usr/share/zsh-antidote/antidote.zsh"
zstyle ':antidote:bundle' file "$XDG_CONFIG_HOME/zsh/rc/plugins.txt"
zstyle ':antidote:static' file "$XDG_CONFIG_HOME/zsh/rc/plugins.zsh"
antidote load

# Load p10k
[[ ! -f "$XDG_CONFIG_HOME/zsh/rc/p10k.zsh" ]] || source "$XDG_CONFIG_HOME/zsh/rc/p10k.zsh"

# Load core components
. "$XDG_CONFIG_HOME/zsh/rc/opts.zsh"
. "$XDG_CONFIG_HOME/zsh/rc/keybindings.zsh"
. "$XDG_CONFIG_HOME/zsh/rc/macros.zsh"

# zsh-users/zsh-history-substring-search
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=white,bold,underline"
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true

# MichaelAquilina/zsh-autoswitch-virtualenv
export AUTOSWITCH_VIRTUAL_ENV_DIR="${XDG_DATA_HOME}/venvs"

# Tarrasch/zsh-autoenv
export AUTOENV_FILE_ENTER=".autoenv.zsh"
export AUTOENV_FILE_LEAVE=".autoenv.exit.zsh"

# Load manual plugins
. "$XDG_CONFIG_HOME/sh/util"
shload "rc.zsh" "$XDG_CONFIG_HOME/zsh"
unsetutil
