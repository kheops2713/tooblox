#!/bin/bash

read -r -p "Passphrase: " -s pw
echo -n "$pw" | ssh -o UserKnownHostsFile=~/.ssh/known_hosts.initramfs "root@$1"
