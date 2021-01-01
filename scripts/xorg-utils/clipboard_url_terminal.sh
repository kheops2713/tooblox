#!/bin/bash

TERMWIN="xfce4-terminal"
CMD="url"

u=${1:-$(xclip -out -selection clipboard)}

xdotool search --onlyvisible xfce4-terminal windowactivate && \
  sleep 0.8 && \
  xdotool key Ctrl+Shift+t && \
  sleep 0.2 && \
  xdotool type --delay 20 "$CMD $u" && \
  xdotool key Return
