#!/bin/bash
 
res=$(echo "lock|logout|reboot|shutdown" | rofi -sep "|" -dmenu -i -p 'Power Menu: ' "" -width 10 -hide-scrollbar -padding 12 -opacity 100 -auto-select -no-fullscreen) 

if [ $res = "lock" ]; then
    /usr/bin/i3lock-fancy -pt ''
fi
if [ $res = "logout" ]; then
    i3-msg exit
fi
if [ $res = "reboot" ]; then
    systemctl reboot
fi
if [ $res = "shutdown" ]; then
    systemctl poweroff
fi
exit 0
