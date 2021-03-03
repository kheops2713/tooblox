#!/bin/bash

MUTTRC_ACCOUNTS_FILES=~/.mutt/accounts-rc/*.muttrc

BASE_IDX=6

idx=$BASE_IDX
fshortcuts=""
for rcfile in $MUTTRC_ACCOUNTS_FILES; do
  echo "macro index <F${idx}> '<enter-command>source $rcfile<enter><change-folder>!<enter>'"
  fshortcuts="${fshortcuts}F${idx}:$(basename $rcfile .muttrc) "
  idx=$(($idx+1))
done

echo "set my_fshortcuts=\"${fshortcuts%% }\""
