#!/bin/bash
# this script's job is to switch my desktop backgrounds (or maybe rotate if I wanted to and added the logic)
# There must be two image files for night and day arbitrarily named, I originally planned to use it to switch to a black background at night
# but I instead found it more useful to have it triggered by a keypress in my desktop environment so I can switch between two backgrounds with a single keystroke.
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
