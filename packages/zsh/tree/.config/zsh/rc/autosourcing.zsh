#!/bin/zsh

# Hook direnv
eval "$(direnv hook zsh)"

# MichaelAquilina/zsh-autoswitch-virtualenv
export AUTOSWITCH_VIRTUAL_ENV_DIR="${XDG_DATA_HOME}/venvs"

# Tarrasch/zsh-autoenv
export AUTOENV_FILE_ENTER=".autoenv.zsh"
export AUTOENV_FILE_LEAVE=".autoenv.exit.zsh"
