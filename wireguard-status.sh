#!/bin/bash

# Allows you to toggle selected NetwrokManager profile on/off
# returning it's current state (suitable for a Polybar widget)
# Accepts two argiments:
# > wireguard-status.sh XXXX --toggle
#     XXXX - your wireguard profile, imported from wg-quick
#     --toggle - switches profile on/off depening on current state
#
# This also assumes you use NetworkManager and you have nmcli installed

[[ $1 ]] || {
    echo 'No VPN interface' && exit 0
}

[[ $(nmcli connection show "${1}" 2> /dev/null) ]] || {
    echo 'Incorrect interface' && exit 0
}

[[ "$2" = "--toggle" ]] && {
    if [[ $(nmcli -f GENERAL.STATE connection show "${1}" | grep activated) ]]
    then
        nmcli connection down "${1}" > /dev/null
    else
        nmcli connection up "${1}" > /dev/null
    fi
}

if [[ $(nmcli -f GENERAL.STATE connection show "${1}" | grep activated) ]]
then
    echo '🔒 VPN on' && exit 0
else
    echo '🔓 VPN off' && exit 0
fi

