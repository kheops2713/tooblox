#!/bin/bash

if [ -z "$PGP_ID" ]; then
  echo Need to set environment variable PGP_ID to your PGP ID >&2
  exit 1
fi

THRESHOLD=$((48*3600)) # 48 hours

now=$(date +%s)

gpg --with-colons --list-keys "$PGP_ID"|grep ^sub:u | \
{
validuses=""
while read subkeyline; do
  IFS=: linearray=($subkeyline)
  sk_ID=${linearray[4]}
  sk_exp=${linearray[6]}
  sk_use=${linearray[11]}
  validuses="${validuses}${sk_use}"
  timeleft=$(($sk_exp-$now))
  if [ $timeleft -lt $THRESHOLD ]; then
    echo Subkey "$sk_ID" \(use \""$sk_use"\"\) expires in $timeleft seconds
  fi
done 

es_uses=$(echo "$validuses" | grep -o '[es]' |tr -d '\n')
if [ ${#es_uses} -lt 2 ]; then
   echo At least one of encryption and signature usage has no valid key \(covered uses are "$validuses"\)
fi


}
