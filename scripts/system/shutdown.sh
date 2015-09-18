#!/bin/bash

# This script must be called twice within some time interval in order to
# shutdown the computer. Can be used for instance to be executed by some
# graphical environment after doing a keyboard shortcut, to avoid shutting down
# by mistake.

DELAY=5
FILE=/tmp/shutdown-request-$USER-$UID

if [ -f $FILE ]; then
  rm -f $FILE
  /usr/bin/systemctl poweroff
else
  touch $FILE
  sleep $DELAY
  rm -f $FILE
fi
