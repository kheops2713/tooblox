#!/bin/bash

MYSELF=$(echo "$1" | tr -c -d '[A-F0-9]')

if [ ${#MYSELF} != 16 ]; then
  echo Error: please specify 16-char long PGP ID. \(\"gpg --with-colons --list-keys\" is convenient for this\) >&2
  exit 2
fi

ALLPUBKEYS=$(gpg --with-colons --list-keys|egrep ^pub: |cut -d: -f5)

for ID in $ALLPUBKEYS; do
  iSigned=$(gpg --with-colons --list-sigs $ID|egrep ^sig:|cut -d: -f5|egrep ^$MYSELF$)
  if [ -n "$iSigned" ]; then
    echo $ID
  fi
done
