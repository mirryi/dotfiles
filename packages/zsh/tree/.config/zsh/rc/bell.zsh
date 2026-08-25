#!/bin/zsh

zmodload zsh/datetime

_bell_preexec() { _bell_cmd_start=$EPOCHSECONDS }
_bell_precmd() {
  (( _bell_cmd_start )) || return
  (( EPOCHSECONDS - _bell_cmd_start >= ${POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD:-3} )) && print -n '\a'
  unset _bell_cmd_start
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _bell_preexec
add-zsh-hook precmd _bell_precmd
