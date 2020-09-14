xmodmap -e 'clear Lock'
xmodmap -e 'keycode 0x42=Escape'
exec wal -R
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec i3
