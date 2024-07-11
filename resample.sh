#!/bin/bash
printUsage () {
	echo "Resamples audio files to 16 bits without dithering using SOX"
	echo usage:
	echo "  $0 threads item [items...]"
	echo "  $0 item [items...]"
	exit
}

if [[ -z "$1" ]] || [[ "$1" = "-h" ]]; then
	printUsage
fi

# if first arg is an int, then spawn that many instances of the script to use parallel processing without real threads
# if arg is not int then it fails and error is directed to NULL
if [ "$1" -eq "$1" ] 2>/dev/null; then
	i=2
	maxArg=$(( ($#-1)/$1 ))
	if [ $(( ($#-1)%$1 )) -ge 1 ]; then
		maxArg=$(($maxArg+1))
	fi
	j=$maxArg
	arg="$0"
	# append files to command counting j down from maxArg then add a new command
	# maxArg is count of filename arguments rounded up in case of a remainder
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
	#execute each instance of this script
	eval $arg
	#fixes terminal sync issue on exit
	sleep "1.5s"
	eval ""
else
	#actually convert the files
	mkdir resampled
	i=1
	while [ $i -le $# ]; do
	eval FILE=\${$i}
	if [ -f "$FILE" ]; then # If there the file exists
		sox -S --multi-threaded "$FILE" -b 16 -D "resampled/$FILE" # Tell SOX to sample at 16bits without any dithering
	else
		echo "$FILE does not exist."
	fi
	i=$(($i+1))
	done
fi