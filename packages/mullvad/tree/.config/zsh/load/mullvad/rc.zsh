#!/bin/zsh
if (( $+commands[mullvad] )); then
  mullvad shell-completions zsh "$XDG_DATA_HOME/zsh/"
fi
