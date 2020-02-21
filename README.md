# SoalShiftSISOP20_modul1_B05

## Penjelasan

### 1. Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”. Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :

#### 1a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit
```
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
```
Langkah-langkah:
- Mengubah separator default(space) menjadi tab dengan
``` awk -F "\t" ```
- Mengeset variabel selatan, tengah, barat, dan timur menjadi 0
``` BEGIN {selatan=0; tengah=0;barat=0;timur=0;} ```
- Setiap di kolom region (kolom ke-13) masukkan nilai profit di kolom profit (kolom ke-21) ke variabel yang telah kita buat sesuai dengan isi dari kolom region (kalo region South, maka masukkan profitnya ke variabel selatan)
``` 
$13 ~ /South/ {selatan=selatan+$21;}
$13 ~ /West/ {barat=barat+$21;}
$13 ~ /East/ {timur=timur+$21;}
$13 ~ /Central/ {tengah=tengah+$21;}
```
- Lalu set nilai variabel selatan ke variabel min dan mengisi variabel reg dengan South
```
min=selatan;
reg="South";
```
- Setelah itu bandingkan nilai variabel min dengan variabel lainnya untuk mencari nilai terkecil
```
if(barat<min){
min=barat;
reg="West";}

if(tengah<min){
min=tengah;
reg="Central";}

if(timur<min){
min=timur;
reg="East";}
```
- Nanti akan ketemu region mana yang memiliki profit terkecil dan akan kita tampilkan
``` print "Region", reg, "memiliki keuntungan terkecil dengan nilai: ", min}' Sample-Superstore.tsv ```

#### 1b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a
```
#soal nomor 1B

echo "2 State terendah dari region yang terpilih di soal 1A"

awk -F "\t" '
{if ($13=="Central") arr[$11]+=$21}
END {for(x in arr) print arr[x] " " x}' Sample-Superstore.tsv | sort -g | head -n 2
printf "\n"
```
Langkah-langkah:
- Mengubah separator default(space) menjadi tab dengan
``` awk -F "\t" ```
- Setelah kita tahu bahwa Region Central memiliki profit terkecil, maka ketika kolom Region (ke-13) tertulis Central, maka kita akan membuat sebuah array arr dengan state-nya sebagai index-nya (kolom ke-11) dan akan diisi dengan nilai profit dari kolom ke-21
``` {if ($13=="Central") arr[$11]+=$21} ```
- Setelah itu kita akan menampilkan hasilnya dengan cara looping array dari awal sampai akhir
``` END {for(x in arr) print arr[x] " " x}' Sample-Superstore.tsv | sort -g | head -n 2 ```
- Namun disini, karena diminta menampilkan 2 state dengan profit terkecil, maka di sort berdasarkan numerik saja
``` sort -g ```
dan menampilkan 2 row teratas setelah di-sort lagi dari kecil ke besar dengan
``` head -n 2 ```

#### 1c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b
```
#soal nomor 1C

echo "10 Produk dengan profit terendah"

awk -F "\t" '
{if ($13=="Central" && ($11=="Texas" || $11=="Illinois")) a[$17]+=$21}
END {for(x in a) print a[x] " " x}' Sample-Superstore.tsv | sort -g | head -n 10
```
Langkah-langkah:
- Mengubah separator default(space) menjadi tab dengan
``` awk -F "\t" ```
- Setelah kita tahu bahwa Region Central memiliki profit terkecil dan 2 State dengan profit terendah adalah Texas dan Illinois, maka kita akan membuat sebuah array a dengan Product Name sebagai index-nya (yaitu kolom ke-17) dan akan diisi dengan nilai profit dari kolom ke-21
```
{if ($13=="Central" && ($11=="Texas" || $11=="Illinois")) a[$17]+=$21}
```
- Setelah itu kita akan menampilkan hasilnya dengan cara looping array dari awal sampai akhir
``` END {for(x in a) print a[x] " " x}' Sample-Superstore.tsv | sort -g | head -n 10 ```
- Namun disini, karena diminta menampilkan 10 Product Name dengan profit terkecil, maka di sort berdasarkan numerik saja
``` sort -g ```
dan menampilkan 10 row teratas setelah di-sort lagi dari kecil ke besar dengan
``` head -n 10 ```

### 2. Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide. Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide tersebut cepat diselesaikan. Idenya adalah kalian

#### 2a. Membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.
Kode dibawah merandom 28 characters yang parameternya semua huruf alphabet baik huruf kapital dan bukan kapital serta angka 0 sampai 9. Setelah itu 28 karakter yang terbentuk akan dijadikan string dan disimpan di variabel password.
``` password=$(cat /dev/urandom | tr -dc _A-Za-z0-9 | head -c28) ```

#### 2b. Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.
```
filename=$1

if [[ $1 =~ ^[a-zA-Z]+$ ]]
then 
password=$(cat /dev/urandom | tr -dc _A-Za-z0-9 | head -c28)
echo password=$password > /home/afiahana/Sisop/Modul1/Soal2/$1.txt
else
echo "Nama File hanya boleh alphabet"
fi
```
- Baris pertama untuk menyimpan argumen yang di-inputkan
- Baris selanjutnya (yang ada if) itu untuk memastikan bahwa argumen yang di-inputkan hanya berupa alphabet saja
- Jika memenuhi kondisi, maka akan membuat password (liat penjelasan 2a) lalu akan disimpan di sebuah file dengan nama sesuai argumen yang di-inputkan dengan ekstensi .txt
- Jika tidak memenuhi kondisi, maka tidak akan membuat password dan akan keluar peringatan "Nama File hanya boleh alphabet"

#### 2c. Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28, maka akan menjadi huruf
```
#!/bin/bash

nama=$1
num=`date +"%H"`
filename="${nama%.txt}"

alphabet="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
Alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"

new=$(echo $filename | tr "${alphabet:0:26}${Alphabet:0:26}" "${alphabet:${num}:26}${Alphabet:${num}:26}")

mv $nama $new.txt
```
Langkah-langkah:
- Menyimpan argumen ke dalam variabel nama
- Menyimpan jam dilakukannya enkripsi ke variabel num
- Memisahkan nama file dengan eksternsinya
- Menjamin urutan a-z dan A-Z terulang kembali
```
alphabet="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
Alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
```
- Melakukan enkripsi, yaitu setiap huruf di filename akan diubah sesuai dengan jam
``` tr "${alphabet:0:26}${Alphabet:0:26}" "${alphabet:${num}:26}${Alphabet:${num}:26}" ```
```tr``` akan translate string awal dengan yang baru. Setelah itu ```"${alphabet:0:26}${Alphabet:0:26}"``` menerima input String. Lalu ```"${alphabet:${num}:26}${Alphabet:${num}:26}"``` akan mengeshift karakter tersebut sesuai jam (yang tersimpan di variabel num)
- Rename nama file yang lama dengan nama file yang baru
``` mv $nama $new.txt ```

#### 2d. jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.
```
#!/bin/bash

nama=$1
num=`date -r $nama +"%H"`
filename="${nama%.txt}"

alphabet="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
Alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"

new=$(echo $filename | tr [${alphabet:${num}:26}${Alphabet:${num}:26}] [${alphabet:0:26}${Alphabet:0:26}])

mv $nama $new.txt
```
Langkah-langkah:
- Menyimpan argumen ke dalam variabel nama
- Menyimpan jam terakhir dilakukannya perubahan terhadap file yang ingin namanya didekripsi ke variabel num
- Memisahkan nama file dengan eksternsinya
- Menjamin urutan a-z dan A-Z terulang kembali
```
alphabet="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
Alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
```
- Melakukan dekripsi, yaitu setiap huruf di filename akan diubah sesuai dengan jam terakhir file tersebut diubah (enkripsi)
``` tr [${alphabet:${num}:26}${Alphabet:${num}:26}] [${alphabet:0:26}${Alphabet:0:26}] ```
```tr``` akan translate string awal dengan yang baru. Setelah itu ```[${alphabet:${num}:26}${Alphabet:${num}:26}]``` menerima input String. Lalu ```[${alphabet:0:26}${Alphabet:0:26}]"``` akan mengeshift karakter tersebut menjadi normal (keadaan dimana karakter belum di shift sesuai jam)
- Rename nama file yang lama dengan nama file yang baru
``` mv $nama $new.txt ```

### 3. 1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma, kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing.

#### 3a. Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam sebuah file "wget.log".
```
#!/bin/bash

for (( num=1; num<=28; num=num+1 ))
do
wget https://loremflickr.com/320/240/cat -O pdkt_kusuma_$num -a wget.log
done
```
Langkah-langkah:
- Looping dari 1-28 karena kita ingin mendownload sebanyak 28 gambar dan untuk nanti penamaannya dari foto yang didownload
- Download foto dari URL yang diberikan dengan penamaan "pdkt_kusuma_NO"
``` wget https://loremflickr.com/320/240/cat ```
- Rename foto yang kita download
``` -O pdkt_kusuma_$num ```
- Simpan log messages wget kedalam sebuah file wget.log . Disini kita menggunakan -a adalah untuk logfile yang sudah ada tidak ter-overwrite. Karena kita ingin menyimpan semua, maka di append saja dengan -a
``` -a wget.log ```

#### 3b. Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download tersebut hanya berjalan setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu
Membuat crontab yang berjalan tiap hari kecuali hari Sabtu dan mulai tiap pukul 6.05 dengan interval 8 jam. Sehingga dia akan berjalan pukul 06.05, 14.05, 22.05 dan akan kembali mulai pukul 06.05 pada keesokan harinya kecuali hari Sabtu.
``` 5 6-23/8 * * 1-5,7 /bin/bash /home/afiahana/Sisop/Modul1/Soal3/soal3.sh ```

#### 3c. Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi ekstensi ".log.bak".
