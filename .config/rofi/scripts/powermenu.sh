#!/usr/bin/env bash

prais="~/.config/rofi/rofi menu/powerlayout.rasi"
rofi_command="rofi -theme"
uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown="󰿅"
reboot="󰜉"
lock="󰌾"

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock"

chosen="$(echo -e "$options" | $rofi_command "$prais" -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        i3lock-fancy 
        ;;
esac

