#!/usr/bin/env bash

options=" Shutdown
 Reboot
 Suspend
 Logout"

choice=$(echo -e "$options" | rofi -dmenu -p "Power Menu")
case "$choice" in
    (" Shutdown") systemctl poweroff ;;
    (" Reboot") reboot ;;
    (" Suspend") systemctl suspend ;;
    (" Logout") hyprctl dispatch exit ;;
esac
