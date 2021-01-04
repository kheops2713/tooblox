#!/bin/bash

CACHE="/home/kheops/.cache/dmenu_web_search"
BROUTEUR="Navigateur Tor"

broute () {
  wmctrl -a "$BROUTEUR" && \
    sleep 0.2 && \
    xdotool key --delay 20 Ctrl+t Ctrl+l && \
    xdotool type "$1" && \
    xdotool key Return
}

u=${1:-$(xclip -out -selection clipboard)}
grep -qxF "$u" $CACHE || echo "$u" >>$CACHE
broute "$u"
