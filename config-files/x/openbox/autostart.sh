/usr/bin/gsettings set org.gnome.system.proxy mode manual
/usr/bin/gsettings set org.gnome.system.proxy.http host localhost
/usr/bin/gsettings set org.gnome.system.proxy.http port 8123
/usr/bin/gsettings set org.gnome.system.proxy.https host localhost
/usr/bin/gsettings set org.gnome.system.proxy.https port 8123
/usr/bin/gsettings set org.gnome.system.proxy.socks host localhost
/usr/bin/gsettings set org.gnome.system.proxy.socks port 9050
tint2 &
redshift &
xautolock -locker /usr/bin/slock -time 3 &
/usr/bin/dunst &
syndaemon -R -t -i 0.7 -k -d
synclient TapButton1=1 TapButton2=2 TapButton3=3
kitty --start-as maximized &
xcompmgr -c &
inputplug -c ~/.config/openbox/kbdplug.sh
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
