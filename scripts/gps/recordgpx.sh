#!/bin/sh

DIR=${1:-.}

if ! which gpxlogger >/dev/null 2>&1; then
    echo gpxlogger is needed and was not found, exiting
    exit 1
fi

if [ ! -d "$DIR" -o ! -w "$DIR" ]; then
    echo Bad perms, exiting
    exit 1
fi

cd "$DIR" || exit 1

while [ 1 ]; do
    FILE=track_$(date +%s).gpx
    starttime=$(date +%s)
    echo Record start
    gpxlogger -i 7 -m 5 -e sockets localhost >$FILE
    stoptime=$(date +%s)
    echo Record stop: duration: $(($stoptime - $starttime))
    sleep 1
done
