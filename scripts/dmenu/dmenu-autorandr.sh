#!/bin/bash

CHOICES=$(autorandr --detected|cut -d' ' -f1)
CHOICE=$(printf "$CHOICES"|dmenu -c -p "Écr.")

if printf "$CHOICES"|grep -qxF "$CHOICE"; then
  autorandr --load "$CHOICE"
fi
