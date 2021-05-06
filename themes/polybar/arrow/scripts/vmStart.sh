#! /bin/sh
#
# vmStart.sh
# Copyright (C) 2020 dashie <dashie@h3k9fb1>
#
# Distributed under terms of the MIT license.
#
amount=$(virsh -c qemu:///system list --all | grep running | wc -l)

if [[ $amount == '0' ]]; then
  virsh -c qemu:///system start win10
  notify-send "WIN Started"
else
  virsh -c qemu:///system shutdown win10
  notify-send "WIN Stopped"
fi

