# start wm in login shell
[ "$(tty)" = "/dev/tty1" ] && exec dbus-run-session river
