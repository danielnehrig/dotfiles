#! /bin/sh
#
# speed.sh
# Copyright (C) 2020 dashie <dashie@h3k9fb1>
#
# Distributed under terms of the MIT license.
#


speed=$(speedtest-cli)
download=$(printf "$speed" | grep Download)
upload=$(printf "$speed" | grep Upload)
downloadFormated=$(printf "$speed" | grep Download | sed -n s/Download://gp | sed -n s/^' '//gp)
uploadFormated=$(printf "$speed" | grep Upload | sed -n s/Upload://gp | sed -n s/^' '//gp)

### set env vars
export NET_DOWNLOAD=$downloadFormated
export NET_UPLOAD=$uploadFormated

### if you wanna execute as stdout instead of setting env vars use this
# echo "%{T3} %{T-}$downloadFormated  %{T3} %{T-}$uploadFormated"
