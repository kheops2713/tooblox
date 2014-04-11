#!/bin/bash

DIR=${1:-.}

PULL_OPTS=""

if [ ! -t 0 ]; then
  PULL_OPTS="$PULL_OPTS --ff-only"
fi

find "$DIR" ! -name .git ! -path '*/.git/*' -type d \
  | while read MAYBE; do cd "$MAYBE" && git rev-parse --show-toplevel 2>/dev/null; done | sort | uniq \
  | while read REPO; do echo "--- $REPO ---" && cd "$REPO" && git pull $PULL_OPTS && git pull --tags; echo "---"; done

