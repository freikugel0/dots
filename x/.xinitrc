#!/bin/sh

# X resources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Keyboard mappings
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# Better Java UI compatibility
export _JAVA_AWT_WM_NONREPARENTING=1

# Desktop/session identity
export XDG_CURRENT_DESKTOP=dwm
export XDG_SESSION_DESKTOP=dwm

# Sync env to systemd user session
systemctl --user import-environment DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP

# Start background services
sxhkd &
dunst &
nm-applet &
lxqt-policykit-agent &
udiskie &
~/.screenlayout &
~/.fehbg &

# Start dwm
exec systemd-cat --identifier=dwm dbus-run-session dwm
