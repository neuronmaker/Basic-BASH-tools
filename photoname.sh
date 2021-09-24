#!/bin/bash
# Exactly what the name says. It will feed the files you want to exiftool which is set to rename the photos to the time stamp which the camera put in the metadata
# Reason I do this is my camera by default uses names like DSC_XXX.JPG or DSC_XXX.NEF where XXXX is a 4 digit numerical serial number, it will wrap around by default or reset to 0000 if a setting is set
# Running this on all new photos ensures that there is no chance that two files will be overwritten for as long as I am onyl using one camera... But I plan to change this as I find better ways to organize my photos.
printUsage () {
  echo "Usage: "
  echo "    $0 [item]"
  echo "    $0"
  exit
}

FILE=$1

if [ "$1" = "-h" ]; then
    printUsage
fi

if [ -z "$1" ]; then
    FILE="*"
fi

exiftool -d '%Y-%m-%d_%H%M%S%-02.c.%%e' '-filename<CreateDate' $FILE
