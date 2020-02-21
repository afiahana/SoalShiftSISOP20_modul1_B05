#!/bin/bash

for (( num=1; num<=28; num=num+1 ))
do
wget https://loremflickr.com/320/240/cat -O pdkt_kusuma_$num -a wget.log
done
