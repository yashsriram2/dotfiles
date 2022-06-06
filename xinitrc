#! /bin/bash
xrandr --output eDP1 --mode 1600x900 --rate 60 && xrandr --output DP2-2 --size 0 --mode 1600x900 --rate 60 --same-as eDP1 --brightness 0.8
bash $XDG_CONFIG_HOME/bg_changer > /dev/null &
xcompmgr &
exec i3
