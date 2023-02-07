#!/bin/bash
# This script's job is to switch my desktop backgrounds (or maybe rotate if I wanted to and added the logic)
# There must be two image files for night and day arbitrarily named, the script will alternate between them when it is run
# I was originally going to make it alternate at certain times of day but I found that binding the script to a key press
# in my desktop manager was more convenient for the way I use my system.
CURRENTPAPER=$(gsettings get org.cinnamon.desktop.background picture-uri)
# The HomeFolder variable makes it work on more systems than just my own.
HomeFolder=$(echo ~)
NIGHTPAPER="file://$HomeFolder/Pictures/Wallpapers/Using/night"#change these to the full path of where you put your wallpapers
DAYPAPER="file://$HomeFolder/Pictures/Wallpapers/Using/day"

# I forget why I put the single quotes in here, but I suspect that they were required and i don't feel like changing them
if [ "$CURRENTPAPER" == "'$DAYPAPER'" ]; then
    #switch to night wallpaper
    gsettings set org.cinnamon.desktop.background picture-uri "$NIGHTPAPER"
else
    #switch to day wallpaper
    gsettings set org.cinnamon.desktop.background picture-uri "$DAYPAPER"
fi
