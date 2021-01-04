#!/bin/bash

TERMWIN="xfce4-terminal"
CMD="url"

u=${1:-$(xclip -out -selection clipboard)}

# Sanitise
u=$(echo "$u" | tr -d '"')

xdotool search --onlyvisible xfce4-terminal windowactivate && \
  sleep 0.8 && \
  xdotool key Ctrl+Shift+t && \
  sleep 0.2 && \
  xdotool type --clearmodifiers --delay 15 "$CMD \"$u\" && exit"
