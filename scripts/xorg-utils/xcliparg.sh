#!/bin/bash

TXT=$1
shift

echo -n "$TXT" | xclip -in $@
