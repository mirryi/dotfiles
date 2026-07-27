#!/bin/bash
pgrep -x i3 >/dev/null || exit 0
i3-msg restart >/dev/null
