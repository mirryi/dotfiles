#!/bin/bash

cache_dir="$XDG_CACHE_HOME/wallpaper"
pid_file="$cache_dir/animated_pid"
toggle_file="$cache_dir/toggled"

read -d $'\0x4' toggle < "$toggle_file"
if [[ $toggle == 1 ]]; then
  echo ""
else
  echo ""
fi
