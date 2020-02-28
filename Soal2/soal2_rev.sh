#!/bin/bash

if [[ $1 =~ ^[a-zA-Z]+$ ]]
then 
pass1=$(cat /dev/urandom | tr -dc A-Z | head -c10)
pass2=$(cat /dev/urandom | tr -dc a-z | head -c9)
pass3=$(cat /dev/urandom | tr -dc 0-9 | head -c9)
echo password=$pass1$pass2$pass3 > /home/afiahana/Sisop/Modul1/Soal2/$1.txt
else
echo "Nama File hanya boleh alphabet"
fi
