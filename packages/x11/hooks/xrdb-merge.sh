#!/bin/bash
[ -n "$DISPLAY" ] || exit 0
xrdb -merge "$1"
