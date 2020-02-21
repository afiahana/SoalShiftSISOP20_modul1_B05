#!/bin/bash


filename=$1

if [[ $1 =~ ^[a-zA-Z]+$ ]]
then 
password=$(cat /dev/urandom | tr -dc _A-Za-z0-9 | head -c28)
echo password=$password > /home/afiahana/Sisop/Modul1/Soal2/$1.txt
else
echo "Nama File hanya boleh alphabet"
fi
