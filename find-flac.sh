#! /bin/bash
# For some reason it's faster to use the find command to find the FLAC files, write their paths to a text file,
# and then send that file into the flac-pipe.sh script than it is to run find and have it execute my scripts directly.
# I don't really care why that is slower since I only run this script occasionally, when I am doing a large import.
# There are probably better ways to do this but I needed something that was quick and dirty just to get one job done.

# Makes it slightly easier to make the script change file names if needed
fileName="flac-files.txt"
find . -name "*.flac" > $fileName
cat $fileName | flac-pipe.sh $1
