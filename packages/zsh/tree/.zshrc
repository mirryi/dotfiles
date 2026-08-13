# GPG password prompt
export GPG_TTY=$(tty)

# open tmux by default
[[ -z $TMUX ]] && exec tmux

# Load shared components
source "$HOME/.config/sh/rc"

# Load p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load core components; antidote runs compinit, so it goes first
. "$XDG_CONFIG_HOME/zsh/rc/antidote.zsh"
. "$XDG_CONFIG_HOME/zsh/rc/p10k.zsh"
. "$XDG_CONFIG_HOME/zsh/rc/opts.zsh"
. "$XDG_CONFIG_HOME/zsh/rc/history.zsh"
. "$XDG_CONFIG_HOME/zsh/rc/keybindings.zsh"
. "$XDG_CONFIG_HOME/zsh/rc/completion.zsh"
. "$XDG_CONFIG_HOME/zsh/rc/navigation.zsh"
. "$XDG_CONFIG_HOME/zsh/rc/autosourcing.zsh"

# Load manual plugins
. "$XDG_CONFIG_HOME/sh/util"
shload "rc.zsh" "$XDG_CONFIG_HOME/zsh"
unsetutil
