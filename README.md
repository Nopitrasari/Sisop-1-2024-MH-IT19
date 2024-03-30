# Laporan Resmi Sistem Operasi Modul 1 Kelompok IT19

Anggota Kelompok IT19 : 
1. Riskiyatul Nur Oktarani (5027231013)
2. Aswalia Novitriasari (5027231012)
3. Benjamin Khawarizmi Habibi (5027231078)

# Deskripsi Praktikum Soal Shift Modul 1 
# SOAL 1
Cipung dan abe ingin mendirikan sebuah toko bernama “SandBox”, sedangkan kamu adalah manajer penjualan yang ditunjuk oleh Cipung dan Abe untuk melakukan pelaporan penjualan dan strategi penjualan kedepannya yang akan dilakukan. Setiap tahun Cipung dan Abe akan mengadakan rapat dengan kamu untuk mengetahui laporan dan strategi penjualan dari “SandBox”. Buatlah beberapa kesimpulan dari data penjualan “Sandbox.csv” untuk diberikan ke cipung dan abe .

A. Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan total sales paling tinggi.

B. Karena karena Cipung dan Abe ingin mengefisienkan penjualannya, mereka ingin merencanakan strategi penjualan untuk customer segment yang memiliki profit paling kecil. Tampilkan customer segment yang memiliki profit paling kecil.

C. Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. Tampilkan 3 category yang memiliki total profit paling tinggi.

D. Karena ada seseorang yang lapor kepada Cipung dan Abe bahwa pesanannya tidak kunjung sampai, maka mereka ingin mengecek apakah pesanan itu ada. Cari purchase date dan amount (quantity) dari nama adriaens.

# PENYELESAIAN
- mendownload file Sandbox.csv dengan menggunakan
  ```wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0' -O Sandbox.csv```
- untuk menampilkan apakah file sudah terdownload dengan benar
  ```ls```
- buat folder dengan format Soal_1, lalu
  ```touch Sandbox.sh```
- Masuk kedalam Soal poin A untuk menampilkan pembeli dengan total sales yang paling tinggi dengan memakai command ```awk```
  
  ```awk -F ',' 'NR > 1 {if(min=="") { min=$20; segment=$7; } else if($20<min) { min=$20; segment=$7; }} END{print segment}' Sandbox.csv | sort | head -n 1```
- Soal poin B untuk menampilkan customer dengan profit paling kecil dengan memakai command ```awk```
  
  ```awk -F ',' 'NR > 1 {if(min=="") { min=$20; segment=$7; } else if($20<min) { min=$20; segment=$7; }} END{print segment}' Sandbox.csv | sort -t',' -k1,1nr | head -3```
- Soal poin C untuk menampilkan 3 kategori yang memiliki total profit paling tinggi
  ```awk -F ',' 'NR > 1 { sales[$14] += $20 } END { PROCINFO["sorted_in"] = "@val_num_desc"; counter = 0; for (cat in sales) { if (counter < 3) { top_cats[cat] = sales[cat]; counter++ } else { for (top_cat in top_cats) { if (sales[cat] > top_cats[top_cat]) { delete top_cats[top_cat]; top_cats[cat] = sales[cat]; break } } } } for (cat in top_cats) print cat, top_cats[cat] }' Sandbox.csv | sort -k2 -rn | head -n 3```
  
- Soal poin D untuk mencari purchase dat dan amount dari nama adriaens ,
  ```awk -F ',' '/Adriaens/ {print $2, $6, $17}' Sandbox.csv```

  # Dokumentasi Output
![output Soal_1](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151106171/d5c71589-237a-4a51-bbca-556a24542f7e)

Berikut adalah hasil yang sudah direvisi. 


# SOAL 2
Oppie merupakan seorang peneliti bom atom, ia ingin merekrut banyak peneliti lain untuk mengerjakan proyek bom atom nya, Oppie memiliki racikan bom atom rahasia yang hanya bisa diakses penelitinya yang akan diidentifikasi sebagai user, Oppie juga memiliki admin yang bertugas untuk memanajemen peneliti,  bantulah oppie untuk membuat program yang akan memudahkan tugasnya 

A. Buatlah 2 program yaitu login.sh dan register.sh

B. Setiap admin maupun user harus melakukan register terlebih dahulu menggunakan email, username, pertanyaan keamanan dan jawaban, dan password

C. Username yang dibuat bebas, namun email bersifat unique. setiap email yang mengandung kata admin akan dikategorikan menjadi admin 

D. Karena resep bom atom ini sangat rahasia Oppie ingin password nya memuat keamanan tingkat tinggi
      
      a. Password tersebut harus di encrypt menggunakan base64
      
      b. Password yang dibuat harus lebih dari 8 karakter
      
      c. Harus terdapat paling sedikit 1 huruf kapital dan 1 huruf kecil
      
      d. Harus terdapat paling sedikit 1 angka 

E. Karena Oppie akan memiliki banyak peneliti dan admin ia berniat untuk menyimpan seluruh data register yang ia lakukan ke dalam folder users file users.txt. Di dalam file tersebut, terdapat catatan seluruh email, username, pertanyaan keamanan dan jawaban, dan password hash yang telah ia buat.
# PENYELESAIAN
# register.sh
```
echo "WELCOME TO REGISTRASION SYSTEM" 
 read -p "enter your email : " email 
read -p "enter your username : " username 
read -p "security question : " security_question
read -p "security answer : " security_answer 
 read -s -p "enter a pasword: " password 
```
ini adalah jawaban untuk yang soal B, untuk register akan disuruh untuk mengisi email, username, pernyataan keamanan dan jawaban, dan password

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/b9aefbe2-cb8d-42a5-a683-994d0c8d93c2)


```
#ngecek apakah email sudah terdaftar apa blum
if grep -q "^$email" users/users.txt; then
	echo "[$(date +'%d/%m/%Y:%M:%S')][REGISTER FAILED]Email $email already registered." >> users/auth.log
	echo "email $email  is already registered"
	exit 1
fi
#untuk mengelompokkan email yg ada kata adminnya
if [[ "$email" == *"admin"* ]]; then
	role="admin"
	echo "[$(date +'%d/%m/%Y:%M:%S')][REGISTER SUCCESS] Admin $username registered succesfully." >> users/auth.log
        echo "Admin $username registered successfully."
else
	role="user"
	echo "[$(date +'%d/%m/%Y:%M:%S')][REGISTER SUCCESS] Admin $username registered succesfully." >> users/auth.log
        echo "user $username registered successfully."
fi
```
ini adalah fungsi untuk menjawab soal C, dimana nanti email yang mengandung kata admin akan dikategorikan sebagai admin dan yang tidak mengandung kata admin akan dikategorikan sebagai user. untuk mungkin diatasnya yaitu agar email bersifat unique.

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/44ded49c-ba71-46a2-9b06-2a6a015cd683)

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/82de1d1b-c22b-4d6e-a893-e7ef137c4f82)

untuk rolenya sudah sesuai

```
#pasword
read -s -p "enter a pasword: " password
echo
while true;do
if [[ ${#password} -lt 8 || !("$password" =~ [[:upper:]] && "$password" =~ [[:lower:]] && "$password" =~ [0-9]) ]]; then
        echo "minimum 8 characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit"
	read -s -p "password: " password
	echo
else
	break
fi
	done

#encrypted passwors
encrypted_password=$(echo -n "$password" | base64)

```
kode diatas menjawab soal yang D dimana password yang dibuat akan terenskrip base64 dan password minimal 8 karakter, 1 huruf besar, 1 huruf kecil dan 1 angka. 

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/4affd0cf-abd6-4382-ba21-42b3ea19f555)

```
echo "$email|$username|$security_question|$security_answer|$role|$encrypted_password" >> users/users.txt
```
sesuai dengan soal yang E hasil dari register akan masuk ke folder users file users.txt

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/54983500-0cc4-4a0b-9293-e77131e6761f)


# soal selanjutnya
F. Setelah melakukan register, program harus bisa melakukan login. Login hanya perlu dilakukan menggunakan email dan password.

G. Karena peneliti yang di rekrut oleh Oppie banyak yang sudah tua dan pelupa maka Oppie ingin ketika login akan ada pilihan lupa password dan akan keluar pertanyaan keamanan dan ketika dijawab dengan benar bisa memunculkan password

H. setelah user melakukan login akan keluar pesan sukses, namun setelah seorang admin melakukan login Oppie ingin agar admin bisa menambah, mengedit (username, pertanyaan keamanan dan jawaban, dan password), dan menghapus user untuk memudahkan kerjanya sebagai admin. 

I. Ketika admin ingin melakukan edit atau hapus user, maka akan keluar input email untuk identifikasi user yang akan di hapus atau di edit

J. Oppie ingin programnya tercatat dengan baik, maka buatlah agar program bisa mencatat seluruh log ke dalam folder users file auth.log, baik login ataupun register.

      a. Format: [date] [type] [message]
      
      b. Type: REGISTER SUCCESS, REGISTER FAILED, LOGIN SUCCESS, LOGIN FAILED
      
      Ex:

        i. [23/09/17 13:18:02] [REGISTER SUCCESS] user [username] registered successfully
        ii. [23/09/17 13:22:41] [LOGIN FAILED] ERROR Failed login attempt on user with email [email]

# PENYELESAIAN
# login.sh
```
if [ "$option" == "1" ]; then
read -p "email: " email
read -s -p "password: " password
echo
#buat ngecek apakah email sudah terdaftar atau belum
infoUser=$(grep "^$email" users/users.txt)

if [ -z "$infoUser" ]; then
	echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN FAILED]no user found with Email $email." >> users/auth.log
        echo "email tidak terdaftar. Registrasi terlebih dahulu"
        exit 1
fi
```
berikut adalah kode untuk menjawab soal F . Pada saat login akan menggunakan informasi email dan password. Fungsi setelahnya berjalan jika email yang dimasukkan tidak terdaftar sebelumnya.

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/8f624fef-60d8-407d-975a-e8b8227dd9bc)

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/3bd3d61a-7eff-4588-becc-92b21a41f014)


```
#untuk forgot password
if [ "$option" == "2" ]; then
	read -p "enter your email: " email

	infoUser=$(grep "^$email" users/users.txt)

if [ -z "$infoUser" ]; then
	echo "[$(date +'%d/%m/%Y:%M:%S')][REGISTER FAILED]no user found with Email $email." >> users/auth.log
	echo "email tidak terdaftar. Registrasi terlebih dahulu"
	exit 1
fi

#untuk melihat password password
security_question=$(echo "$infoUser" | cut -d "|" -f 3)
security_answer=$(echo "$infoUser" | cut -d "|" -f 4)

read -p "securiy question: $security_question security answer : " userAnswer
if [ "$userAnswer" == "$security_answer" ]; then
	stored_password=$(echo "$infoUser" | cut -d "|" -f 6 | base64 -d)
	echo "[$(date +'%d/%m/%Y:%M:%S')][FORGOT PASSWORD]User with Email $email retrieved password." >> users/auth.log
	echo "your password is : $stored_password"
else
	echo "[$(date +'%d/%m/%Y:%M:%S')][FORGOT PASSWORD]ERROR: Incorrect security answer for user with Email $email." >> users/auth.log
	echo "incorrect security answer."
	exit 1
	fi
	fi
```

untuk menjawab soal yang G kita menggunakan kode seperti diatas. jika memilih forgot password maka kita diminta untuk memasukkan email dan akan keluar security question. jika kita menjawab security question sesuai dengan answer question yang ada di data maka akan muncul password kita.

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/b2732ea1-de0c-42c4-b41c-f54ea38580f7)

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/16291d9a-44f3-4bd0-b6b1-c80107afc2b5)

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/83f453d2-2342-4043-8bce-5a9d334f9918)


```
#untuk sinkronisasi password
stored_password=$(echo "$infoUser" | cut -d "|" -f 6 | base64 -d)

if [ "$password" == "$stored_password" ]; then
	echo
	role=$(echo "$infoUser" |cut -d "|" -f 5)
 	if [ "$role" == "admin" ]; then
        echo "welcome admin!"
        echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN SUCCES]admin for Email $email logged in successfully." >> users/auth.log
        echo "admin menu"
        echo "1. add user"
        echo "2. edit user"
        echo "3. delete user"
        read -p "pilihan : " action
```

jika memasukkan email yang mengandung kata "admin" maka akan terdapat menu admin yaitu add user, edit user, delete user.

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/a38bcdbe-18ce-41f8-85bd-b9cc69685a3c)

```
elif [ "$role" == "user" ]; then
	echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN SUCCES]user for Email $email logged in successfully." >> users/auth.log
	echo "welcome user!"
        exit 1
        fi
	fi
```
jika memasukkan email yang tidak mengandung kata "admin" maka akan menjalankan kode diatas.

sebelum revisi

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/c17f5cf0-d53e-41b3-afb2-ff75aa2d8f13)

# REVISI
```
	if [ "$role" == "user" ]; then
	echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN SUCCES]user for Email $email logged in successfully." >> users/auth.log
	echo "welcome user!"
        exit 1
        fi
```

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/d565bd0d-799c-4585-9560-4b45ef0dc26c)


```
else
        echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN FAILED]ERROR: Failed login attempt on user with Email $email" >> users/auth.log
        echo "incorrect password. try again or choose forgot password"
	fi
```

jika password yang dimasukkan salah maka akan menjalankan kode diatas.

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/d256b2be-d7d4-4b3d-9be7-212f485f7e19)


```
if [ "$action" == "1" ]; then
        bash register.sh
```
ini adalah fungsi untuk add user, akan otomatis menjalankan kode di register.sh dan hasilnya akan masuk ke users.txt

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/1432d482-6000-4ac8-b8c7-7aa1e06a0389)

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/8edd36a8-5b20-41bc-a620-fc0574bf8744)

```
elif [ "$action" == "2" ]; then
        read -p "enter email: " edit_email
        if grep -q "$email" users/users.txt; then
        read -p "enter username: " new_username
        read -p "enter security question: " new_security_question
        read -p "enter security answer: " new_security_answer
        read -s -p "enter password: " new_password

        if [[ ${#new_password} -lt 8 || !("$new_password" =~ [[:upper:]] && "$new_password" =~ [[:lower:]] && "$new_password" =~ [0-9]) ]]; then
        echo "[$(date +'%d/%m/%Y:%M:%S')][ADD USER FAILED]Password for Email $email does not meet the strength requirements." >> users/auth.log
        echo"password tidak sesuai"
        exit 1

	else
        encrypted_password=$(echo -n "$new_password" | base64)
        sed -i "s/^$edit_email[^|]*/$edit_email|$new_username|$new_security_question|$new_security_answer|$role|$encrypted_password" users/users.txt
        echo "[$(date +'%d/%m/%Y:%M:%S')][EDITED SUCCESS] Email $edit_email edited succesfully." >> users/auth.log
        echo "edited email $edit_email successfully!."
	exit 1
        fi
	fi

	else
        echo "user not found!"
        exit 1
	fi
```
berikut kode untuk menjalakan edit user, akan diminta untuk memasukkan data baru

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/7a914ab0-ba61-4c49-a6f2-6c35f42e3ceb)

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/6cbdba61-8584-49c0-9703-4c56879cf610)


dari

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/4b9d2d0b-20c5-47ff-b910-41d8208796a9)

menjadi 

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/0a0120fe-9aba-4219-b621-c28883b5be64)

# REVISI
yang direvisi : 

```
  sed -i "s/$edit_email/$edit_email|$new_username|$new_security_question|$new_security_answer|$role|$encrypted_password/" users/users.txt

```
sebelum direvisi tidak mengalami perubahan 

```
elif [ "$action" == "3" ]; then
        read -p "enter email : " email
        if grep -q "$email" users/users.txt; then
        sed -i"/$email/d" users/users.txt
        echo "[$(date +'%d/%m/%Y:%M:%S')][DELETED SUCCESS] deleted succesfully." >> users/auth.log
        echo "deleted successfully"
	else
	echo "pilihan tidak valid"
	exit 1
	fi
	fi
```
# REVISI
untuk delete saya hanya kurang spasi pada sed -i

```
sed -i "/$email/d" users/users.txt
```

dan ini untuk delete user. untuk delete user diminta untuk memasukkan email yang ada di data

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/112e1319-43a4-49a6-b2c5-f75804466ba5)

dari ini

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/d16f6bb8-13e1-4f17-aebc-e17688e13def)

menjadi ini

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/36adc27f-4bf9-4711-aaf5-65b047a1f472)

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/c83a0863-4ed4-4dc2-9b33-4c1e6af4b82e)


```
echo "[$(date +'%d/%m/%Y:%M:%S')][DELETED SUCCESS] deleted succesfully." >> users/auth.log
```
untuk soal terakhir, kodenya sesuai diatas menyesuaikan dengan kondisi masing masing

![image](https://github.com/Nopitrasari/Sisop-1-2024-MH-IT19/assets/151911480/79548530-718d-4f6e-9930-0c60c3e1cecf)


# SOAL 3
Alyss adalah seorang gamer yang sangat menyukai bermain game Genshin Impact. Karena hobinya, dia ingin mengoleksi foto-foto karakter Genshin Impact. Suatu saat Yanuar memberikannya sebuah Link yang berisi koleksi kumpulan foto karakter dan sebuah clue yang mengarah ke penemuan gambar rahasia. Ternyata setiap nama file telah dienkripsi dengan menggunakan hexadecimal. Karena penasaran dengan apa yang dikatakan Yanuar, Alyss tidak menyerah dan mencoba untuk mengembalikan nama file tersebut kembali seperti semula.

A. Alyss membuat script bernama awal.sh, untuk download file yang diberikan oleh Yanuar dan unzip terhadap  file yang telah diunduh dan decode setiap nama file yang terenkripsi dengan hex . Karena pada file list_character.csv terdapat data lengkap karakter, Alyss ingin merename setiap file berdasarkan file tersebut. Agar semakin rapi, Alyss mengumpulkan setiap file ke dalam folder berdasarkan region tiap karakter
Format: Region - Nama - Elemen - Senjata.jpg

B. Karena tidak mengetahui jumlah pengguna dari tiap senjata yang ada di folder "genshin_character".Alyss berniat untuk menghitung serta menampilkan jumlah pengguna untuk setiap senjata yang ada
Format: [Nama Senjata] : [jumlah]
	 Untuk menghemat penyimpanan. Alyss menghapus file - file yang tidak ia gunakan, yaitu genshin_character.zip, list_character.csv, dan genshin.zip

C. Namun sampai titik ini Alyss masih belum menemukan clue dari the secret picture yang disinggung oleh Yanuar. Dia berpikir keras untuk menemukan pesan tersembunyi tersebut. Alyss membuat script baru bernama search.sh untuk melakukan pengecekan terhadap setiap file tiap 1 detik. Pengecekan dilakukan dengan cara meng-ekstrak sebuah value dari setiap gambar dengan menggunakan command steghide. Dalam setiap gambar tersebut, terdapat sebuah file txt yang berisi string. Alyss kemudian mulai melakukan dekripsi dengan hex pada tiap file txt dan mendapatkan sebuah url. Setelah mendapatkan url yang ia cari, Alyss akan langsung menghentikan program search.sh serta mendownload file berdasarkan url yang didapatkan.

Dalam prosesnya, setiap kali Alyss melakukan ekstraksi dan ternyata hasil ekstraksi bukan yang ia inginkan, maka ia akan langsung menghapus file txt tersebut. Namun, jika itu merupakan file txt yang dicari, maka ia akan menyimpan hasil dekripsi-nya bukan hasil ekstraksi. Selain itu juga, Alyss melakukan pencatatan log pada file image.log untuk setiap pengecekan gambar
Format: [date] [type] [image_path]
Ex: 
[24/03/20 17:18:19] [NOT FOUND] [image_path]
[24/03/20 17:18:20] [FOUND] [image_path]
Hasil akhir:
genshin_character
search.sh
awal.sh
image.log
[filename].txt
[image].jpg

# Penyelesaian

Membuat script dengan command 
`` nano awal.sh `` \

``
#!/bin/bash
#download file
wget -O genshin.zip 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'
#unzip filenya terus pindahin ke folder khusus terserah
unzip genshin.zip -d genshinNo1_folder
#Decode nama file yang terenkripsi dengan hexadecimal
cd genshinNo1_folder
unzip genshin_character.zip
for genshin_character; do
    decoded_filename=$(echo "$genshin_character" | xxd -r -p)
    mv "$genshin_character" "$decoded_filename" 
#Baca data karakter dari list_character.csv dan menyesuaikan setiap file ke dalam folder sesuai region tiap karakter
cat list_character.csv | sed 's/\r$//' | awk -F ',' '{ printf "mv \"%s - %s - %s - %s.jpg\" \"%s - %s - %s - %s.jpg\"\n", $1, $2, $3, $4, $1, $2, $3, $4 }' | bash
#buat folder sesuai setiap region karakternya
cat list_character.csv | sed 's/\r$//' | awk -F ',' '{ printf "mkdir -p \"%s\"\n", $1 }' | bash done < list_character.csv ``

Penjelasn Singkat dari script awal.sh, jadi kit pertama perlu mendownload file dari link yang tersedia dengan 
`` wget -O genshin.zip 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN' ``

mengekstrak file zip yang didonwload tadi, lalu saya pindahkan hasil ekstraksi ke folder genshinNo1_folder(folder random)
``unzip genshin.zip -d genshinNo1_folder``
``cd genshinNo1_folder`` 

mendecode file list_character.csv dari genshin_character.zip dan sekaligus menyortir file dalam genshin_character agar sesuai region setiap karakter agar ebih rapi den tertata sesuai format yang diminta 
``
for genshin_character; do
    decoded_filename=$(echo "$genshin_character" | xxd -r -p)
    mv "$genshin_character" "$decoded_filename" 
#Baca data karakter dari list_character.csv dan menyesuaikan setiap file ke dalam folder sesuai region tiap karakter
cat list_character.csv | sed 's/\r$//' | awk -F ',' '{ printf "mv \"%s - %s - %s - %s.jpg\" \"%s - %s - %s - %s.jpg\"\n", $1, $2, $3, $4, $1, $2, $3, $4 }' | bash
#buat folder sesuai setiap region karakternya
cat list_character.csv | sed 's/\r$//' | awk -F ',' '{ printf "mkdir -p \"%s\"\n", $1 }' | bash done < list_character.csv 
``

Kemudian menyimpan dan mengubah permission file script agar dapat dieksekusi
`` chmod +x ./awal.sh ``

lalu menjalankan scriptnya
`` bash awal.sh `` atau ``./awalsh``

Output yang diberikan 




