#!/bin/zsh
# The zjstatus plugin pane keeps the session alive after the last shell exits,
# which hangs the terminal. Kill the session on shell exit, but ONLY when this
# is the last terminal pane -- otherwise just let the single pane close.
# ponytail: strict ==1; on any list-panes error we don't kill, so the worst case
# is the hang returning, never nuking a multi-pane session.
if [[ -n $ZELLIJ ]]; then
    zshexit() {
        local n=$(zellij action list-panes 2>/dev/null | awk '$2 == "terminal"' | wc -l)
        (( n == 1 )) && zellij kill-session "$ZELLIJ_SESSION_NAME" 2>/dev/null
        true
    }
fi
