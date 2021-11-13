#! /bin/bash
#uses find to find flac files, spits them to a text file, then reads that text file into script
#that then passes it into the flac script that sends the files into the flac converter.
#crude but effective. I could make it work without using a file as an intermediate step
#but the file allows a user to read what file were found.
#note this is faster than running find and having it execute the flac script for some reason that is 
#beyond me which is why this script exists at all since it should be better to use find to do this
#directly.
find . -name "*.flac" > flac-files.txt
cat flac-files.txt | flac-pipe.sh $1
