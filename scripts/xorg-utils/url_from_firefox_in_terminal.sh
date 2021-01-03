#!/bin/sh

TERMWIN="xfce4-terminal"
CMD="url"

t=$(cat | dd bs=1 skip=4 | sed 's/^"//;s/"$//')

xdotool search --onlyvisible xfce4-terminal windowactivate && \
  sleep 0.8 && \
  xdotool key Ctrl+Shift+t && \
  sleep 0.2 && \
  xdotool type --delay 15 "$CMD $u" && \

