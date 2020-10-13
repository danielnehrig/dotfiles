#!/usr/bin/env bash

prais="~/.config/rofi/config.rasi"
rofi_command="rofi -theme"
uptime=$(uptime -p | sed -e 's/up //g')

# Options
wing="WIN GAMES"
wine="WIN ENDIT"
ubuntu="UBUNUTU"

# Variable passed to rofi
options="$wing\n$wine\n$ubuntu"

chosen="$(echo -e "$options" | $rofi_command "$prais" -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
    $wing)
        virsh -c qemu:///system start win10-games-2
        ;;
    $wine)
        virsh -c qemu:///system start win10-edit
        ;;
    $ubuntu)
        virsh -c qemu:///system start ubuntu20.04
        ;;
esac

