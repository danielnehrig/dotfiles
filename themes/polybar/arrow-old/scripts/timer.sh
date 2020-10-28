#! /bin/sh
#
# timer.sh
# Copyright (C) 2020 dashie <dashie@h3k9fb1>
#
# Distributed under terms of the MIT license.
#

seconds=1080; date1=$((`date +%s` + $seconds)); 
while [ "$date1" -ge `date +%s`  ]; do 
    notify-send "$(date -u --date @$(($date1 - `date +%s` )) +%M:%S)"
    # echo -ne "$(date -u --date @$(($date1 - `date +%s` )) +%M:%S)\r"; 
    sleep 60
done
notify-send "Pizza Done"
