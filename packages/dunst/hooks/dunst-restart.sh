#!/bin/bash
# reload in place
dunstctl reload 2>/dev/null || setsid -f dunst
