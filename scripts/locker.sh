#!/bin/bash

if [[ "$1" == "enable" ]]; then
  echo enable
  light-locker --lock-after-screensaver=30
  xset s 120
  xset s on
  xset dpms 600 600 600
  xset +dpms
fi

if [[ "$1" == "disable" ]]; then
  echo disable
  killall light-locker
  xset s 0 0
  xset s off
  xset dpms 0 0 0
  xset -dpms
fi
