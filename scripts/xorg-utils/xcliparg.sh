#!/bin/bash

TXT=$1
shift

echo "$TXT" | xclip -in $@
