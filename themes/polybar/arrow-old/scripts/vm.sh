#! /bin/sh
#
# vm.sh
# Copyright (C) 2020 dashie <dashie@h3k9fb1>
#
# Distributed under terms of the MIT license.
#


amount=$(virsh -c qemu:///system list --all | grep running | wc -l)

if [[ $amount == '0' ]]; then
  echo "%{F#ff3333}󱐝%{F-}"
else
  echo "%{F#2dffa4}󰆧%{F-}"
fi
