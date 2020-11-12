#!/bin/sh
SERVICE="screenkey"
if pgrep -x "$SERVICE" >/dev/null
then
  pkill -f screenkey
else
  screenkey
fi
