#! /bin/sh
#
# loopbackinput.sh
# Copyright (C) 2020 dashie <dashie@h3k9fb1>
#
# Distributed under terms of the MIT license.
#

# M-Audio interface alsa loopback to hear yourself talking or any input device
latency=4
pactl list | grep loopback
EXITCODE=$?
test $EXITCODE -eq 1 || pactl unload-module module-loopback
test $EXITCODE -eq 0 || pactl load-module module-loopback latency_msec=$latency

#old
# pkill -f pacat || pacat -r --latency-msec=$latency -d alsa_input.usb-M-Audio_M-Track_2X2M-00.analog-stereo | pacat -p --latency-msec=$latency -d alsa_output.usb-M-Audio_M-Track_2X2M-00.iec958-stereo
