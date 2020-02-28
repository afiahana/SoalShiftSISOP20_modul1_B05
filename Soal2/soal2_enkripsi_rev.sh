#!/bin/bash

nama=$1
num=`date -r $nama +"%H"`
filename="${nama%.txt}"

alphabet="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
Alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"

new=$(echo $filename | tr "${alphabet:0:26}${Alphabet:0:26}" "${alphabet:${num}:26}${Alphabet:${num}:26}")

mv $nama $new.txt
