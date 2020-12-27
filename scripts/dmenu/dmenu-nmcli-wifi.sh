#!/bin/bash

bssid=Rafraichir

while [ "$bssid" = "Rafraichir" ]; do
  scan=$(nmcli -g bssid,freq,bars,in-use,security,ssid device wifi list | \
    /usr/bin/perl -pe \
    's/^([0-9A-F]{2})\\:([0-9A-F]{2})\\:([0-9A-F]{2})\\:([0-9A-F]{2})\\:([0-9A-F]{2})\\:([0-9A-F]{2}):([0-9]* MHz):([▂▄▆█_\* ]*):([ \*]):([A-Za-z0-9 ]*):(.*)/$1:$2:$3:$4:$5:$6  $11($7)  $8  $10  $9/' ; echo Rafraichir)


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
