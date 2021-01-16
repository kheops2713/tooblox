#!/bin/sh

TERMWIN="xfce4-terminal"
CMD="url"

# Use with url_externalapp firefox extension

# Idiotic parsing of data sent by Firefox (see
# https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Native_messaging#App_side)
t=$(cat | dd bs=1 skip=4 | tr -d '"')

xdotool search --onlyvisible "Terminal - " windowactivate && \
  sleep 0.2 && \
  xdotool key Ctrl+Shift+t && \
  sleep 0.2 && \
  xdotool type --clearmodifiers --delay 15 "$CMD \"$t\""
