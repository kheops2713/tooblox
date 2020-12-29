#!/bin/bash

CACHE="/home/kheops/.cache/dmenu_web_search"
BROUTEUR="Tor Browser"

q=$(sort -u $CACHE | dmenu -l 10 -c -fn "Serif-14")

if [ -z "$q" ]; then
  exit
fi

echo "$q" >>$CACHE

wmctrl -a "$BROUTEUR" && \
  sleep 0.5 && \
  xdotool key --delay 50 Ctrl+t Ctrl+l && \ 
  xdotool type "$q" && \
  xdotool key Return
