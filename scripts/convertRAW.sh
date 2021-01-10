#! /bin/sh
#
# convertRAW.sh
# Copyright (C) 2021 dashie <dashie@h3k9fb1>
#
# Distributed under terms of the MIT license.
#


cp -R ~/camera/DCIM/100MSDCF/*.ARW ~/Pictures/Camera
for f in ~/Pictures/Camera/*.ARW; do
  convert $f $f.jpg
  # do some stuff here with "$f"
  # remember to quote it or spaces may misbehave
done
