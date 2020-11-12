#! /bin/sh
#
# loopbackinput.sh
# Copyright (C) 2020 dashie <dashie@h3k9fb1>
#
# Distributed under terms of the MIT license.
#
#old
pkill -f pacat || pacat -r --latency-msec=1 -d alsa_input.usb-M-Audio_M-Track_2X2M-00.analog-stereo | pacat -p --latency-msec=1 -d alsa_output.usb-M-Audio_M-Track_2X2M-00.iec958-stereo

# PulseAudio Loopback toggle input source
if false
then
  latency=1
  if pactl list 2>&1 | grep "loopback" > /dev/null
  then
    pactl unload-module module-loopback
    notify-send "Loopback off"
  else
    pactl load-module module-loopback latency_msec=$latency
    notify-send "Loopback on"
  fi
fi
