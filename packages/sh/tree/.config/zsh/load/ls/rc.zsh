#!/bin/zsh

# the ls aliases run eza, so complete them as eza rather than ls
if [ "$(command -v eza)" ]; then
	compdef ls=eza
	compdef la=eza
	compdef lt=eza
	compdef ltl=eza
fi
