#!/bin/bash

#download file
wget -O genshin.zip 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'

#unzip filenya terus pindahin ke folder khusus terserah
unzip genshin.zip -d genshinNo1_folder

# Decode nama file yang terenkripsi dengan hexadecimal
cd genshinNo1_folder
unzip genshin_character.zip
for genshin_character; do
    decoded_filename=$(echo "$genshin_character" | xxd -r -p)
    mv "$genshin_character" "$decoded_filename"
done 

# Baca data karakter dari list_character.csv dan menyesuaikan setiap file ke dalam folder sesuai region tiap karakter
cat list_character.csv | sed 's/\r$//' | awk -F ',' '{ printf "mv \"%s - %s - %s - %s.jpg\" \"%s - %s - %s - %s.jpg\"\n", $1, $2, $3, $4, $1, $2, $3, $4 }' | bash

# buat folder sesuai setiap region karakternya
cat list_character.csv | sed 's/\r$//' | awk -F ',' '{ printf "mkdir -p \"%s\"\n", $1 }' | bash
 < list_character.csv
