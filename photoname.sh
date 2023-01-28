#!/bin/bash
# Exactly what the name says. It will feed the files you want into exiftool which is set to rename the photos to the time stamp which the camera put in the file's metadata
# The reason I do this is my camera by default uses names like DSC_XXXX.JPG or DSC_XXXX.NEF where XXXX is a 4 digit numerical serial number, it will wrap around or reset depending on a certain camera setting... hence the reason this script exists.
# Running this on all new photos ensures that there is no chance that files will be overwritten for as long as I am only using one camera at a time... But I plan to change this as I find better ways to organize my photos.
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
#if no files passed, select everything in this directory, this is for lazy usage and can try to rename files in all subdirectories. Be careful with that.
if [ -z "$1" ]; then
    FILE="*"
fi

exiftool -d '%Y-%m-%d_%H%M%S%-02.c.%%e' '-filename<CreateDate' $FILE
