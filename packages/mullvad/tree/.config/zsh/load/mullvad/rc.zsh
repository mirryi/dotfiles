#!/bin/zsh
if (( $+commands[mullvad] )); then
  if [[ ! -f "$XDG_DATA_HOME/zsh/_mullvad" ]]; then
    mullvad shell-completions zsh "$XDG_DATA_HOME/zsh/"
  fi
fi
