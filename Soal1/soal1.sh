#!/bin/bash

#soal nomor 1A

echo "Menampilkan Region dengan profit terendah"

awk -F "\t" '
BEGIN {selatan=0; tengah=0;barat=0;timur=0;}

$13 ~ /South/ {selatan=selatan+$21;}
$13 ~ /West/ {barat=barat+$21;}
$13 ~ /East/ {timur=timur+$21;}
$13 ~ /Central/ {tengah=tengah+$21;}
END {

min=selatan;
reg="South";

if(barat<min){
min=barat;
reg="West";}

if(tengah<min){
min=tengah;
reg="Central";}

if(timur<min){
min=timur;
reg="East";}

print "Region", reg, "memiliki keuntungan terkecil dengan nilai: ", min}' Sample-Superstore.tsv
printf "\n"

#soal nomor 1B

echo "2 State terendah dari region yang terpilih di soal 1A"

awk -F "\t" '
{if ($13=="Central") arr[$11]+=$21}
END {for(x in arr) print arr[x] " " x}' Sample-Superstore.tsv | sort -g | head -n 2
printf "\n"

#soal nomor 1C

echo "10 Produk dengan profit terendah"

awk -F "\t" '
{if ($13=="Central" && ($11=="Texas" || $11=="Illinois")) a[$17]+=$21}
END {for(x in a) print a[x] " " x}' Sample-Superstore.tsv | sort -g | head -n 10
