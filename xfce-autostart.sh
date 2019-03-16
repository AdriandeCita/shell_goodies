#! /bin/bash

if ! [[ $(pgrep firefox) ]]
then
    firefox-developer-edition &
fi

while ! [[ "$(wmctrl -l)" =~ "Firefox" ]] 
do
    sleep 1;
done
wmctrl -r firefox -t 0;

if ! [[ $(pgrep xfce4-terminal) ]]
then
    xfce4-terminal &
fi

while ! [[ "$(wmctrl -l)" =~ "Terminal" ]] 
do
    sleep 1;
done
wmctrl -r terminal -t 1;
wmctrl -r terminal -b add,maximized_vert,maximized_horz;

telegram-desktop &
while ! [[ "$(wmctrl -l)" =~ "Telegram" ]] 
do
    sleep 1;
done
wmctrl -r telegram -t 2;

skypeforlinux &
while ! [[ "$(wmctrl -l)" =~ "Skype" ]] 
do
    sleep 1;
done
wmctrl -r skype -t 2;

slack &
while ! [[ "$(wmctrl -l)" =~ "Slack" ]] 
do
    sleep 1;
done
wmctrl -r slack -t 2;

