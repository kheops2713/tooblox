#!/bin/sh

MUTTRC_ACCOUNTS_FILES=~/.mutt/accounts-rc/*.muttrc

BASE_IDX=6

idx=$BASE_IDX
for rcfile in $MUTTRC_ACCOUNTS_FILES; do
  echo "macro index <F${idx}> '<enter-command>source $rcfile<enter><change-folder>!<enter>'"
  idx=$(($idx+1))
done