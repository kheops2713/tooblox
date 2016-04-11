tint2 &
redshift &
xautolock -locker /usr/bin/slock -time 3 &
urxvt -bl -geometry $(xrandr|egrep -m1 '\*\+$'|awk {'print $1'})+0+0 &
