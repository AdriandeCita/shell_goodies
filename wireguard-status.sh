#!/bin/bash

# Allows you to toggle selected NetwrokManager profile on/off
# returning it's current state (suitable for a Polybar widget)
# Accepts two argiments:
# > wireguard-status.sh XXXX [--toggle|--status]
#     XXXX - your wireguard profile, imported from wg-quick
#     --toggle - switches profile on/off depening on current state
#     --status - check status and display a notification with information about
#       exit point
# This also assumes you use NetworkManager and you have nmcli installed

[[ $1 ]] || {
    echo 'No VPN interface' && exit 0
}

[[ $(nmcli connection show "${1}" 2> /dev/null) ]] || {
    echo 'Incorrect interface' && exit 0
}

[[ "$2" = "--status" ]] && {
    if [[ $(nmcli -f GENERAL.STATE connection show "${1}" | grep activated) ]]
    then
        ipInfo=$(curl -s ipinfo.io)
        remoteIp=$(echo "$ipInfo" | jq ".ip")
        country=$(echo "$ipInfo" | jq ".country")
        city=$(echo "$ipInfo" | jq ".city")
        organization=$(echo "$ipInfo" | jq ".org")
        msg="Your IP: ${remoteIp}\nCountry: ${country}\nCity: ${city}\nOrganization: ${organization}"
        notify-send "Your current VPN" "$msg"
        exit 0;
    else
        notify-send "Not connected!"
        exit 0;
    fi
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
    echo '%{F#689d6a}🔓 VPN on%{F-}' && exit 0
else
    echo '%{F#cc241d}🔓 VPN off%{F-}' && exit 0
fi

