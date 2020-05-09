if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  source "$XDG_CONFIG_HOME/sh/env"
  exec startx "$XDG_CONFIG_HOME/X11/xinitrc" \
    -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1 > "$XDG_LOG_HOME/X11/startx.log"
fi
