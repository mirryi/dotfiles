#!/bin/zsh
# Kill the zellij session when the shell exits, matching tmux's last-pane behavior.
# Use C-a x (CloseFocus) to close a single pane without ending the session.
if [[ -n $ZELLIJ ]]; then
    zshexit() { zellij kill-session "$ZELLIJ_SESSION_NAME" 2>/dev/null; true }
fi
