exec xset r rate 300 60
exec xrdb -merge ~/.Xresources
exec xrandr --setprovideroutputsource modesetting NVIDIA-0
exec xrandr --auto
exec setxkbmap -layout us,de -option caps:escape -option 'grp:alt_shift_toggle'
exec i3
