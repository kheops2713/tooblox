#!/bin/bash

BROUTERM="xfce4-terminal"
DMENU="dmenu -nb #7fb97b -nf #10400d -sb #a6dda2 -sf #10400d -l 10 -c -fn Serif-13"
CMD=url

. ~/.local/lib/fonctions.sh

broute () {
  u=$(echo "$1" | tr -d '"')
  xdotool search --onlyvisible "$BROUTERM" windowactivate && \
    sleep 0.2 && \
    xdotool key Ctrl+Shift+t && \
    sleep 0.2 && \
    xdotool type --clearmodifiers --delay 15 "$CMD \"$u\" && exit" && \
    xdotool key Return
}

case "$1" in 
  histclean)
    while [ 1 ]; do
      u=$(urlls | $DMENU -p 🧹 | cut -d" " -f1)
      if [ -z "$u" ]; then exit; fi
      urlrm -f "$u"
    done
    ;;
  *)
    u=$(urlls | $DMENU -p 🐐 | cut -d" " -f1)
    if [ -z "$u" ]; then exit; fi
    broute "$u"
    ;;
esac
