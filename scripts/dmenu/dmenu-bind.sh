#!/bin/bash
if [ -n "$1" ]; then
  exe=`dmenu_path | dmenu -b -nb '#151617' -nf '#d8d8d8' -sb '#d8d8d8' -sf '#151617'` && eval "exec $1 $exe"
else
  exe=`dmenu_path | dmenu -b -nb '#151617' -nf '#d8d8d8' -sb '#d8d8d8' -sf '#151617'` && eval "exec $exe"
fi
