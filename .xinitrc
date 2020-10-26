exec xset r rate 400 100
exec xrandr --setprovideroutputsource modesetting NVIDIA-0
exec xrandr --auto
exec xrdb -merge ~/.Xresources
exec xrandr --dpi 150/DP-2
exec setxkbmap -layout us,de -option caps:escape -option 'grp:alt_shift_toggle'
exec i3
