#!/bin/bash

CONFIG_FILE=~/.config/ping-hosts

# Chaque ligne du fichier correspond à un hôte à pinger

while read hostline; do
  host=$(echo "$hostline" | cut -d' ' -f1)
  options=$(echo "$hostline" | cut -d' ' -f2-)
  notifok=0

  for o in $options; do
    case $o in
      "notif-ok")
        notifok=1
        ;;
      *)
        ;;
    esac
  done

  retstr=$(ping -c 1 "$host")
  retcode=$?
  if [ $retcode -gt 0 ]; then
    notifyresult="erreur"
    notifyicon=dialog-warning
    notify-send -i $notifyicon -t 10000 "${host} : $notifyresult"
    sleep 10
  elif [ $notifok = 1 ]; then
    notifyresult=$(echo "$retstr" | tail -n 1 | sed  's#.* = \([0-9.]*\)/.*#\1 ms#')
    notifyicon=dialog-information
    notify-send -i $notifyicon -t 10000 "${host} : $notifyresult"
    sleep 10
  fi
done <"$CONFIG_FILE"
