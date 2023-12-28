#!/bin/bash

while [ -n "$1" ]; do
  certfile=$1
  if [ ! -r "$certfile" ]; then
    echo "'$certfile' pas lisible"
  else
    echo "* ${certfile} :"
    echo "  - CN : $(openssl x509 -in "$certfile" -noout -text  | sed '/^ *Subject:/!d;s/^.*CN = \([A-Za-z0-9.]*\).*/\1/')"
    echo "  - SAN :"
    openssl x509 -in "$certfile" -noout -text | sed '/DNS:/!d;s/DNS://g;s/, /\n/g;s/^ */         /;s/\n/\n         /g' | sort
  fi
  shift
done
