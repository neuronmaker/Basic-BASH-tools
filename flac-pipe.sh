#! /bin/bash
flacList="flac.sh $1"
while read flacPath; do
    #escape the "'" character so it's "\'"
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
    #echo $flacPath
    flacList="$flacList '$flacPath'"
#    echo $flacList
done
    
eval $flacList
