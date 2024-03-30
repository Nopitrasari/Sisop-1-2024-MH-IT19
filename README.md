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
``` echo "WELCOME TO REGISTRASION SYSTEM" ```
``` read -p "enter your email : " email ```
``` read -p "enter your username : " username ```
``` read -p "security question : " security_question ```
``` read -p "security answer : " security_answer ```
``` read -s -p "enter a pasword: " password ```

ini adalah jawaban untuk yang soal B, untuk register akan disuruh untuk mengisi email, username, pernyataan keamanan dan jawaban, dan password

# SOAL 3
Alyss adalah seorang gamer yang sangat menyukai bermain game Genshin Impact. Karena hobinya, dia ingin mengoleksi foto-foto karakter Genshin Impact. Suatu saat Yanuar memberikannya sebuah Link yang berisi koleksi kumpulan foto karakter dan sebuah clue yang mengarah ke penemuan gambar rahasia. Ternyata setiap nama file telah dienkripsi dengan menggunakan hexadecimal. Karena penasaran dengan apa yang dikatakan Yanuar, Alyss tidak menyerah dan mencoba untuk mengembalikan nama file tersebut kembali seperti semula.

A. Alyss membuat script bernama awal.sh, untuk download file yang diberikan oleh Yanuar dan unzip terhadap  file yang telah diunduh dan decode setiap nama file yang terenkripsi dengan hex . Karena pada file list_character.csv terdapat data lengkap karakter, Alyss ingin merename setiap file berdasarkan file tersebut. Agar semakin rapi, Alyss mengumpulkan setiap file ke dalam folder berdasarkan region tiap karakter
Format: Region - Nama - Elemen - Senjata.jpg

Membuat script dengan command 
nano awal.sh 

Kemudian menyimpan dan mengubah permission file script agar dapat dieksekusi
chmod +x ./awal.sh 

lalu menjalankan scriptnya





