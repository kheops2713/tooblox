#!/bin/bash

if [ -z "$PGP_ID" ]; then
  echo Need to set environment variable PGP_ID to your PGP ID >&2
  exit 1
fi

convertsecs2dhms () {
    local d=$((${1}/(60*60*24)))
    local h=$(((${1}%(60*60*24))/(60*60)))
    local m=$(((${1}%(60*60))/60))
    local s=$((${1}%60))
    printf -v printValue "%02d days %02d hours %02d minutes %02d seconds \n" $d $h $m $s
    echo "$printValue"
}

THRESHOLD=${PGP_EXPIRE_THRESHOLD:-$((48*3600))} # 48 hours by default

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
    echo Subkey "$sk_ID" \(use \""$sk_use"\"\) expires in $(convertsecs2dhms $timeleft)
  fi
done 

es_uses=$(echo "$validuses" | grep -o '[es]' |tr -d '\n')
if [ ${#es_uses} -lt 2 ]; then
   echo At least one of encryption and signature usage has no valid key \(covered uses are "$validuses"\)
fi


}
