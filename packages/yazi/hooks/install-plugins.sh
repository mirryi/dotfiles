#!/bin/bash
command -v ya >/dev/null 2>&1 || exit 0

plugins_dir="${XDG_CONFIG_HOME:-$HOME/.config}/yazi/plugins"

declare -A plugins=(
	[git.yazi]="yazi-rs/plugins:git"
	[smart-enter.yazi]="yazi-rs/plugins:smart-enter"
	[jump-to-char.yazi]="yazi-rs/plugins:jump-to-char"
	[lazygit.yazi]="Lil-Dank/lazygit"
	[mediainfo.yazi]="boydaihungst/mediainfo"
	[compress.yazi]="KKV9/compress"
	[yamb.yazi]="h-hg/yamb"
)

for dir in "${!plugins[@]}"; do
	[ -d "$plugins_dir/$dir" ] || ya pkg add "${plugins[$dir]}"
done
