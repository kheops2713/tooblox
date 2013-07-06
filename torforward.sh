#!/bin/bash

LISTEN=$1
TORSOCKS=$2
TARGET=$3

if [ -z "$LISTEN" -o -z "$TORSOCKS" -o -z "$TARGET" ]; then
  echo Syntax: "$0" '<port to listen on>' '<local Tor socks proxy port>' '<target_host>:<target_port>'
  echo
  echo Note: the target can be a Tor hidden service.
  exit 1
fi

echo Listening on 127.0.0.1:$LISTEN... Make sure the SOCKS proxy on port $TORSOCKS is running:
echo '--- [snip] ---'
netstat -laputen | grep LISTEN | grep :$TORSOCKS
echo '--- [snip] ---'

socat -s TCP4-LISTEN:$LISTEN,bind=127.0.0.1,fork,reuseaddr SOCKS4A:127.0.0.1:$TARGET,socksport=$TORSOCKS,forever,interval=10

