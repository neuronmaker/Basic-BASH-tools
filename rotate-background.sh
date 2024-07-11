#!/bin/bash
# A script to alternate my backgrounds, developed for Linux Mint Cinnamon edition
# Make the DAYPAPER and NIGHTPAPER variables match the names of two images and it will alternate them
CURRENTPAPER=$(gsettings get org.cinnamon.desktop.background picture-uri)
# The HomeFolder variable makes it work on more systems than just my own.
HomeFolder=$(echo ~)
NIGHTPAPER="file://$HomeFolder/Pictures/Wallpapers/Using/night"#change these to the full path of where you put your wallpapers
DAYPAPER="file://$HomeFolder/Pictures/Wallpapers/Using/day"

if [ "'$CURRENTPAPER'" == "'$DAYPAPER'" ]; then
	#switch to night wallpaper
	gsettings set org.cinnamon.desktop.background picture-uri "$NIGHTPAPER"
else
	#switch to day wallpaper
	gsettings set org.cinnamon.desktop.background picture-uri "$DAYPAPER"
fi
