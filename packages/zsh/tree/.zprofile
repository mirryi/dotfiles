# Load shared components
source "$HOME/.config/sh/profile"

# Load manual plugins
. "$XDG_CONFIG_HOME/sh/util"
shload "env.zsh" "$XDG_CONFIG_HOME/zsh"
unsetutil

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx "$XDG_CONFIG_HOME/X11/xinitrc" \
		-- "$XDG_CONFIG_HOME/X11/xserverrc" vt1
fi

