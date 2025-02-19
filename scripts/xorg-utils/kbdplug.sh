#!/bin/sh

# Script to use with inputplug (https://github.com/andrewshadura/inputplug)

event=$1 id=$2 type=$3

case "$event $type" in
  'XIDeviceEnabled XISlaveKeyboard')
    setxkbmap -option compose:prsc fr
esac
