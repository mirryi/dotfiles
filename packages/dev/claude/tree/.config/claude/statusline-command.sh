#!/bin/bash
# Gruvbox-themed status line for Claude Code.

input=$(cat)

# Gruvbox palette.
c_green=$'\033[38;5;106m'
c_cyan=$'\033[38;5;109m'
c_magenta=$'\033[38;5;175m'
c_gray=$'\033[38;5;243m'
c_dim=$'\033[2m'
c_reset=$'\033[0m'
# Gruvbox "faded" tones for usage percentages, by threshold.
c_faded_green=$'\033[38;5;100m'
c_faded_yellow=$'\033[38;5;136m'
c_faded_orange=$'\033[38;5;130m'
c_faded_red=$'\033[38;5;88m'

sep="${c_dim}${c_gray} | ${c_reset}"

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
repo_name=$(basename "$cwd")
model_name=$(echo "$input" | jq -r '.model.display_name // "unknown"')
effort=$(echo "$input" | jq -r '.effort.level // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
session_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')

# Git branch, skipping optional locks (no repo writes, avoids lock contention).
branch=$(git --git-dir="$cwd/.git" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ -z "$branch" ]; then
    branch=$(cd "$cwd" 2>/dev/null && git --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
fi

# Left: repo name (green) + branch (cyan, parens).
left="${c_green}${repo_name}${c_reset}"
if [ -n "$branch" ]; then
    left="${left}${c_cyan} (${branch})${c_reset}"
fi

# Color for a usage percentage, by threshold.
pct_color() {
    local pct_int=$1
    if [ "$pct_int" -ge 90 ]; then
        echo "$c_faded_red"
    elif [ "$pct_int" -ge 70 ]; then
        echo "$c_faded_orange"
    elif [ "$pct_int" -ge 20 ]; then
        echo "$c_faded_yellow"
    else
        echo "$c_faded_green"
    fi
}

# Abbreviated effort level.
case "$effort" in
    low) effort_abbrev="low" ;;
    medium) effort_abbrev="med." ;;
    high) effort_abbrev="high" ;;
    xhigh) effort_abbrev="xh." ;;
    max) effort_abbrev="max" ;;
    *) effort_abbrev="" ;;
esac
model_block="${model_name}"
[ -n "$effort_abbrev" ] && model_block="${model_block} (${effort_abbrev})"

# Right: session % | context % | model (effort).
right=""
if [ -n "$session_pct" ]; then
    session_int=${session_pct%.*}
    [ -z "$session_int" ] && session_int=0
    session_pct_display=$(printf "%.0f" "$session_pct")
    right="${right}$(pct_color "$session_int")${session_pct_display}%${c_reset}${sep}"
fi

used_int=${used_pct%.*}
[ -z "$used_int" ] && used_int=0
pct_display=$(printf "%.0f" "$used_pct")
right="${right}$(pct_color "$used_int")${pct_display}%${c_reset}${sep}"

right="${right}${c_magenta}${model_block}${c_reset}"

printf "%s   %s\n" "$left" "$right"
