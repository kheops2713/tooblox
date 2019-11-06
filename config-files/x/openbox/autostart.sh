tint2 &
redshift &
xautolock -locker /usr/bin/slock -time 3 &
/usr/lib/notify-osd-customizable/notify-osd &
syndaemon -R -t -i 0.7 -k -d
synclient TapButton1=1 TapButton2=2 TapButton3=3
urxvt -bl &
