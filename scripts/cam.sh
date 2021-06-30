#! /bin/sh
#
# cam.sh
# Copyright (C) 2020 dashie <dashie@h3k9fb1>
#
# Distributed under terms of the MIT license.
#


pkill -f mpv || mpv --no-osc --geometry=-0-0 --autofit=30% av://v4l2:/dev/video0 --profile=low-latency --untimed
