#!/bin/zsh

# complete the git aliases as their underlying subcommand
compdef g=git
compdef _git gc=git-commit
compdef _git gcmsg=git-commit
compdef _git gp=git-push
compdef _git gl=git-pull
compdef _git gf=git-fetch
compdef _git gd=git-diff
compdef _git gco=git-checkout
compdef _git gcl=git-clone
