#!/bin/bash

bssid=Rafraichir

# This to convince nmcli it can display bars instead of stars for signal
# strength
export TERM=xterm-256color

while [ "$bssid" = "Rafraichir" ]; do
  scan=$(nmcli -g bssid,freq,bars,in-use,security,ssid device wifi list | \
    /usr/bin/perl -pe \
    's/^([0-9A-F]{2})\\:([0-9A-F]{2})\\:([0-9A-F]{2})\\:([0-9A-F]{2})\\:([0-9A-F]{2})\\:([0-9A-F]{2}):([0-9]* MHz):([▂▄▆█_\* ]*):([ \*]):([A-Za-z0-9 .]*):(.*)/$1:$2:$3:$4:$5:$6  $11($7)  $8  $10  $9/' ; echo Rafraichir)

# Note: -c option of dmenu is only present in some (patched) versions of it

  sel=$(echo "$scan" | \
        dmenu -l 10 -c \
          -nb '#000000' \
          -nf '#aaaaaa' \
          -sb '#000000' \
          -sf '#00ff00' \
          -fn 'Monospace-14')

  bssid=$(echo "$sel" | cut -d' ' -f1)
done

if [ -n "$bssid" ]; then
  nmcli device wifi connect "$bssid"
fi
