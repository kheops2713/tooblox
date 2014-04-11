#!/bin/bash

DIR=${1:-.}

PULL_OPTS=""

if [ ! -t 0 ]; then
  PULL_OPTS="$PULL_OPTS --ff-only"
fi

cd "$DIR"

for file in *; do
  if [ -d "$file" ]; then
    echo "--- $file ---"
    cd "$file" && git pull $PULL_OPTS && git pull --tags
    cd ..
    echo "---"
  fi
done
