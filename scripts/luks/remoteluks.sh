#!/bin/bash

REMOTEHOST=$1

if [ -z "$REMOTEHOST" ]; then
  echo Usage: $0 \<remote_host\> >&2
  exit 1
fi

read -r -p "Passphrase: " -s pw
echo -n "$pw" | ssh -o UserKnownHostsFile=~/.ssh/known_hosts.initramfs "root@$1"
