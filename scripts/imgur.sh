#! /bin/sh
#
# screenshot.sh
# Copyright (C) 2020 dashie <dashie@h3k9fb1>
#
# Distributed under terms of the MIT license.
#

now=imgur.png

notify-send "Start"
# scrot -s /home/dashie/Pictures/Screenshots/$now
/home/dashie/.local/bin/imgur-uploader /home/dashie/Pictures/Screenshots/$now > /home/dashie/temp
cat /home/dashie/temp | grep -o 'https.*' | xclip -selection clipboard
notify-send "Done"
rm /home/dashie/Pictures/Screenshots/$now
rm temp
