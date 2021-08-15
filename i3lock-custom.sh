#!/bin/bash

# create a temp file
img=$(mktemp /tmp/XXXXXXXXXX.png)

# Take a screenshot of current desktop
import -window root $img 

# Pixelate the screenshot
convert $img -scale 10% -scale 1000% $img

# Run i3lock with custom background
i3lock -u -i $img

# Remove the tmp file
rm $img
