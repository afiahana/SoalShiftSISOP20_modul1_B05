#!/bin/bash

for (( num=1; num<=28; num=num+1 ))
do
wget https://loremflickr.com/320/240/cat -O pdkt_kusuma_$num -a wget.log
done

grep 'Location' wget.log >> location.log

mkdir duplicate
mkdir kenangan

cd duplicate
d=$(ls | grep -o '[0-9]*' | sort -nr | head -n 1)
d=$(($d+1))

cd ..
cd kenangan
k=$(ls | grep -o '[0-9]*' | sort -nr | head -n 1)
k=$(($k+1))
cd ..

for ((x=1;x<=28;x=x+1))
do
	for ((y=$x+1;y<=28;y=y+1))
	do
		if diff -s "pdkt_kusuma_$x" "pdkt_kusuma_$y"
		then 
			mv pdkt_kusuma_$y ./duplicate/duplicate_$d
			d=$(($d+1))
		fi
	done
done

for ((num=1;num<=28;num=num+1))
do
	mv pdkt_kusuma_$num ./kenangan/kenangan_$k
	k=$(($k+1))
done
cat wget.log > wget.log.bak
cat location.log > location.log.bak
