#!/bin/bash
# This script is a wrapper for FLAC encoder installed on my system. Graphical tools exist but the command line FLAC
# seems to do a better job with regards to efficiency (at least on my system).
# It will take a FLAC file or many FLAC files, encode them with the in the "PAYLOAD" section.
# Assuming there are no errors, it will keep the smaller of the two and delete the larger file.
# FLAC is a lossless encoder so maximum compression does not degrade audio quality.
# The only downside to the saved space being more CPU time to compress the audio, for me this is acceptable since
# it is a one-time cost, and this script will encode a series of files automatically while I go for lunch or coffee.
printUsage () {
	echo usage:
	echo "  $0 threads item [items...]"
	echo "  $0 item [items...]"
	exit
}

successReplaceTemp () {
	# check the old and new file sizes and if the new file is smaller then replace the old file with it otherwise abort
	osize="$(wc -c <"$FILE")"
	nsize="$(wc -c <"$TempFile")"
	if [ "$osize" -gt "$nsize" ]; then
		echo "$FILE size decreased by $(($osize-$nsize)) bytes"
		#replace the old file with the temp file, if extension is not flac then append
		rm "$FILE"
		if [ "${FILE:((${#FILE}-5)):5}" = ".flac" ]; then
			mv "$TempFile" "$FILE"
		else
			mv "$TempFile" "$FILE.flac"
		fi
	else
		echo "$FILE was not shrunk, Abort"
		rm "$TempFile"
	fi
}

failRemoveTemp () {
	# check for common errors using known strings and grep
	ERR="should be < 1.0"
	if [ -n "$( echo $OUT | grep "$ERR" )" ]; then
		echo "$FILE FAILED! Ratio is > 1!"
	else
		echo "$FILE FAILED!"
	fi
	rm "$TempFile"
}

if [[ -z "$1" ]] || [[ "$1" = "-h" ]]; then
	printUsage
fi

# if first arg is an int then fork into that many threads, otherwise run in sequence, if arg is not int then it fails and error is directed to NULL
if [ "$1" -eq "$1" ] 2>/dev/null; then
	# Subtract the threading option argument, see if there is a remainder after evenly splitting the tracks across the forks
	i=2
	maxArg=$(( ($#-1)/$1 ))
	if [ $(( ($#-1)%$1 )) -ge 1 ]; then
        maxArg=$(($maxArg+1))
	fi
	j=$maxArg
	arg="$0"
	# append files to command counting j down from maxArg then add a new command
	# maxArg is files/threads rounded up so if there is a remainder the last thread just takes less
	while [ $i -le $# ]; do
		if [ $j -le 0 ];then
			arg="$arg & $0 "
			j=maxArg
		fi
		eval FILE=\${$i}
		#escape the "'" character so it's "\'"
		len=${#FILE}
		pos=0
		while [ $pos -lt $len ]; do
			if [ "'" = "${FILE:pos:1}" ];then
				FILE="${FILE:0:pos}'\\'${FILE:pos:(($len-$pos))}"
				len=${#FILE}
				pos=$(($pos+3))
			fi
			pos=$(($pos+1))
		done
		arg="$arg '$FILE'"
		j=$(($j-1))
		i=$(($i+1))
	done
	eval $arg
	#fixes terminal sync issue on exit
	sleep "1.5s"
	eval ""
else
	#actually convert the files
	i=1
	while [ $i -le $# ]; do
		eval FILE=\${$i}
		TempFile="$FILE.tmp"
		if [ -f "$FILE" ]; then
			# ------------      PAYLOAD command is here         -------------
			# execute flac encoder and store the error, if null then assume successful encode otherwise fail and erase temp file
			# faster encoding without the exhaustive search of all encoding models
			# OUT=$( flac -s --verify --best --output-name="$TempFile" "$FILE" 2>&1 )
			# slower but slightly more space efficient way to encode exhaustive searching for best model
			# Since encoding is a one-time cost, I find this an acceptable tradeoff
			 OUT=$( flac -s -e --replay-gain --verify --best --output-name="$TempFile" "$FILE" 2>&1 ) #Alternately this should be replaceable with many commands... just a thought.
			if [ -z "$OUT" ]; then
				successReplaceTemp
			else
				#try to see if the error ends in "dropping existing cuesheet..." and make it success, That is not an error that I care about
				pos=${#OUT}
				pos=$(($pos-29))
				echo "${OUT:pos}"
				if [ "${OUT:pos}" = "dropping existing cuesheet..." ]; then
					successReplaceTemp
					echo "         WARNING, lead-out offset of cuesheet in input FLAC file does not match input length, dropping existing cuesheet..."
				else
					#assume there was an error and remove the temporary file, leaving original as the fail-safe
					failRemoveTemp
				fi
			fi
		else
			echo "$FILE does not exist."
		fi
		i=$(($i+1))
	done
fi
