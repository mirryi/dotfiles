#!/usr/bin/env bash
tmpbg="/tmp/screen.png"
scrot "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
# i3lock -n -i "$HOME/files/images/wallpaper/gruvbox/koi.png" \
i3lock -n -i "$tmpbg" \
  --insidecolor=37344500 --ringcolor=ffffffff --line-uses-inside \
  --keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
  --insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
  --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+86:y+1003" \
  --radius=15 --veriftext="" --wrongtext=""
rm "$tmpbg"
