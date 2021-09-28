#! /bin/bash
pactl set-sink-volume alsa_output.pci-0000_00_1f.3.analog-stereo 80%
xrandr --auto
xrandr --output eDP-1 --brightness 0.55
xcompmgr &
exec i3
