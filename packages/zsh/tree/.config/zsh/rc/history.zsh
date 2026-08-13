#!/bin/zsh

# save history in state dir
export HISTSIZE=290000
export SAVEHIST=290000
export HISTFILE="$XDG_STATE_HOME/zsh/history"
mkdir -p "${HISTFILE:h}"

# do not write duplicates to history
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
# save each command's beginning timestamp and the duration to the history file
setopt EXTENDED_HISTORY
# share new history across active zsh sessions
setopt SHARE_HISTORY

# zsh-users/zsh-history-substring-search
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=white,bold,underline"
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true

# Initialize atuin (Ctrl-R only; up-arrow stays with history-substring-search)
eval "$(atuin init zsh --disable-up-arrow)"
