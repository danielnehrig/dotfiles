#! /bin/sh
#
# speed.sh
# Copyright (C) 2020 dashie <dashie@h3k9fb1>
#
# Distributed under terms of the MIT license.
#

### crontab job (pacman -S cronie)
### crontab -e
### every hour and 10min start speedtest
# 10 * * * * speedtest-cli > /home/dashie/.config/polybar/scripts/speedlog

speed=$(cat ~/.config/polybar/scripts/speedlog)
download=$(printf "$speed" | grep Download)
upload=$(printf "$speed" | grep Upload)
downloadFormated=$(printf "$speed" | grep Download | sed -n 's|.*Download:||gp' | sed -n 's| ||gp' | sed -n 's|Mbit/s||gp')
uploadFormated=$(printf "$speed" | grep Upload | sed -n 's|.*Upload:||gp' | sed -n 's| ||gp' | sed -n 's|Mbit/s||gp')

echo "%{T3}%{F$1}%{F-} %{T-}$downloadFormated  %{T3}%{F$1}%{F-} %{T-}$uploadFormated"
