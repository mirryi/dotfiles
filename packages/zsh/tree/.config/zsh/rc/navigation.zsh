#!/bin/zsh

# Initialize zoxide
eval "$(zoxide init zsh)"

# Complete from the zoxide database; zoxide's own compdef only offers local dirs
_z_complete() {
  local -a matches
  matches=(${(f)"$(zoxide query --list --exclude "$PWD" -- ${words[2,CURRENT]} 2>/dev/null)"})
  compadd -U -a matches || _files -/
}
compdef _z_complete z

# Traverse up the filesystem n times
up() {
  LIMIT=$1
  LIMIT=${LIMIT:-1}
  P=$PWD
  for ((i = 1; i <= LIMIT; i++)); do
    P=$P/..
  done
  cd $P
}
