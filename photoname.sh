#!/bin/bash
# Exactly as the name says. This script takes files on the command line and feeds them to exiftool, exiftool will rename
# the files according to the supplied template, here I have set it to rename to the data and time code with a number at
# the end of the name. The number is in case the camera shoots two photos in the same second so they don't overwrite
# each other.

# Word of warning: careful where this is run, exiftool can rename other files that are not images such as videos, some PDFs, etc.
# If no files are supplied, then exiftool gets fed all the files in the current working directory... including other
# directories... recursively...
# I use this after a photo shoot in order to rename all my new photos regardless of what mess of folders they're in,
# but if you run this on a directory like your home folder or one with a link to other directories... it will check and
# attempt to rename ALL files in ALL folders it finds. This is acceptable behavior for me since I use it only on my import
# directories. Just be careful.
printUsage () {
  echo "Usage: "
  echo "    $0 [item]"
  echo "    $0"
  exit
}

FILE=$1

if [ "$1" = "-h" ]; then
    printUsage
else
  # if no files passed, select everything in this directory, this is for lazy usage and can try to rename files in all subdirectories. Be careful with that.
  if [ -z "$1" ]; then
      FILE="*"
      # check if we are in the user's home folder, and if we are then don't run
      if [ $(pwd) = ~ ]; then
        echo "Aborting, I won't work directly on user's home folders."
        FILE=""
      fi
  fi
fi

if [ -z "$FILE" ]; then
  # do nothing
    echo "Aborted, check specified arguments and ensure you're not in the root of your home directory"
  else
    # Run if there are now files in the FILE variable
    exiftool -d '%Y-%m-%d_%H%M%S%-02.c.%%e' '-filename<CreateDate' $FILE
fi