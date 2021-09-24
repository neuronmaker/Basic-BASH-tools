#!/bin/bash

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
