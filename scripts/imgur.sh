#! /bin/sh
#
# screenshot.sh
# Copyright (C) 2020 dashie <dashie@h3k9fb1>
#
# Distributed under terms of the MIT license.
#

now=imgur.png

scrot -s ~/Pictures/Screenshots/$now
imgur-uploader ~/Pictures/Screenshots/$now > temp
cat temp | grep -o 'https.*' | xclip -selection clipboard
rm ~/Pictures/Screenshots/imgur.png
rm temp
