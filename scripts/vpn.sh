cd $HOME/vpn

VPN=$(ls *.ovpn | rofi -dmenu -p "VPN: ")

[ -z "$VPN" ] && exit

pkill -f openvpn && alacritty -e /bin/bash -c "sudo openvpn $HOME/vpn/$VPN"
