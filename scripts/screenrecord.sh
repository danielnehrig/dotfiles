#! /bin/sh
#
# screenrecord.sh
# Copyright (C) 2020 lain <lain@cyberia>
#
# Distributed under terms of the MIT license.
#

pc="dnehrig"
macbook="lain"
filePath=~/screencast/screen1_recording_`date '+%Y-%m-%d_%H-%M-%S'`.mp4
SERVICE="ffmpeg"

if [[ "$USER" == "$pc" ]]
then
  pkill -f ffmpeg && notify-send "ffmpeg stopped" || ffmpeg -y -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0 -f pulse -ac 2 -i 0 ~/screencast/screen1_recording_`date '+%Y-%m-%d_%H-%M-%S'`.mp4 && notify-send "Record screen1_recording_`date '+%Y-%m-%d_%H-%M-%S'`.mp4"
elif [[ "$USER" == "$macbook" ]]
then
  if pgrep -x "$SERVICE" >/dev/null
  then
    pkill -f ffmpeg
    notify-send "ffmpeg stopped"
  else
    notify-send "Record screen1_recording_`date '+%Y-%m-%d_%H-%M-%S'`.mp4" 
    ffmpeg -y -video_size 2880x1800 -framerate 30 -f x11grab -i :1.0 -f pulse -ac 2 -i 1 -c:v libx264rgb -crf 0 -preset ultrafast $filePath
fi
fi

