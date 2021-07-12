#! /bin/sh
cd $HOME/vpn


SERVICE="openvpn"
if pgrep -x "$SERVICE" >/dev/null
then
  pkill -f openvpn
else
  VPN=$(ls *.ovpn | rofi -dmenu -p "VPN: ")
  USER=dNehrig
  MASTERPW=$(printf '' | rofi -dmenu -p "BW PW" -password -lines 0) || exit $?
  PW=$(echo $MASTERPW | bw get password OWA)
  TOKEN=$(printf '' | rofi -dmenu -p "TOTP: " -password -lines 0) || exit $?
  PWTOKEN=$PW$TOKEN
  SUDA=$(printf '' | rofi -dmenu -p "SUDO: " -password -lines 0) || exit $?

  rm $HOME/vpn/login.conf
  echo $USER >> $HOME/vpn/login.conf
  echo $PWTOKEN >> $HOME/vpn/login.conf

  [ -z "$VPN" ] && exit
  [ -z "$USER" ] && exit
  [ -z "$PWTOKEN" ] && exit
  [ -z "$SUDA" ] && exit

  echo $SUDA | sudo -S openvpn --config /home/dnehrig/vpn/$VPN --auth-user-pass /home/dnehrig/vpn/login.conf
fi

