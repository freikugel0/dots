#!/bin/sh

# X resources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Keyboard mappings
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# Cursor
xsetroot -cursor_name cross

# Better Java UI compatibility
export _JAVA_AWT_WM_NONREPARENTING=1

# GTK theme consistency
export GTK_THEME=Adwaita:dark

# Start background services
sxhkd &
dunst &
nm-applet &
lxqt-policykit-agent &
udiskie &
~/.screenlayout &
~/.fehbg &

# Start dwm inside dbus session
exec systemd-cat --identifier=dwm dbus-run-session dwm
