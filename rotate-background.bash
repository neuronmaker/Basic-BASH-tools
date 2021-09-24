#!/bin/bash

CURRENTPAPER=$(gsettings get org.cinnamon.desktop.background picture-uri)

NIGHTPAPER="file:///home/dalton/Pictures/Wallpapers/Using/night.jpg"
DAYPAPER="file:///home/dalton/Pictures/Wallpapers/Using/day.jpg"

if [ "$CURRENTPAPER" == "'$DAYPAPER'" ]; then
    #switch to night wallpaper
    gsettings set org.cinnamon.desktop.background picture-uri "$NIGHTPAPER"
else
    #switch to day wallpaper
    gsettings set org.cinnamon.desktop.background picture-uri "$DAYPAPER"
fi
