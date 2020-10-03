#! /bin/sh
#
# aupdates.sh
# Copyright (C) 2020 dashie <dashie@h3k9fb1>
#
# Distributed under terms of the MIT license.
#

updateValue=$(checkupdates | wc -l)
zero=0
if [ $updateValue -eq $zero ];
then
  echo " "
else
  echo " $updateValue "
fi
