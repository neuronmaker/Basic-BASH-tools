#!/bin/bash
#This needs flac.sh to be accessible, change the string below (flaclist) to whatever script you want to load.
#This is merely a loader script that was made to make flac.sh work with text files or the output of the find tool
flacScript="flac.sh"
# make the next command a variable for easy changing later on other systems
flacList="$flacScript $1"
while read flacPath; do
	#escape the "'" character so it's "\'" in the string. This makes ugly file names work with FLAC
	len=${#flacPath}
	pos=0
	while [ $pos -lt $len ]; do
		if [ "'" = "${flacPath:pos:1}" ];then
			flacPath="${flacPath:0:pos}'\\'${flacPath:pos:(($len-$pos))}"
			len=${#flacPath}
			pos=$(($pos+3))
		fi
		pos=$(($pos+1))
	done
	#append each argument
	flacList="$flacList '$flacPath'"
done
# launch the script payload with the arguments loaded
eval $flacList
