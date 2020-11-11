#! /bin/sh
#
# ghcheck.sh
# Copyright (C) 2020 lain <lain@cyberia>
#
# Distributed under terms of the MIT license.
#

current=$(pwd)
cd ~/code/work/$1
echo $(gh pr checks)
cd $current
