tint2 &
redshift &
urxvt -bl -geometry $(xrandr|egrep -m1 '\*\+$'|awk {'print $1'})+0+0 &
