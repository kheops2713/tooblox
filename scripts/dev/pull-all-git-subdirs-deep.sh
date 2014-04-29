#!/bin/bash

DIR=${1:-.}

PULL_OPTS=""

if [ ! -t 0 ]; then
  PULL_OPTS="$PULL_OPTS --ff-only"
fi

find "$DIR" ! -name .git ! -path '*/.git/*' -type d \
  | while read MAYBE; do if [ -d "$MAYBE/.git" ]; then
      git --work-tree "$MAYBE" --git-dir "$MAYBE/.git" rev-parse --show-toplevel 2>/dev/null
      fi
    done | sort | uniq \
  | while read REPO; do
      echo "--- $REPO ---"
      git --work-tree "$REPO" --git-dir "$REPO/.git" pull $PULL_OPTS && git --work-tree "$REPO" --git-dir "$REPO/.git" pull --tags
      echo "---"
    done

