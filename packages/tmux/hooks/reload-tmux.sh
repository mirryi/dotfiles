#!/bin/bash
tmux has-session 2>/dev/null || exit 0
tmux source-file "${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
