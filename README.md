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




