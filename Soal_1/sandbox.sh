#unduh file sandbox.csv menurut perintah soal menggunakan command 'wget', '--no-check-certificate' untuk menonaktifkan pemeriksaan sertifikat SSL,
wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0' -O Sandbox.csv
#menampilkan file apa saja dan memastikan apakah file yang diunduh sudah tersedia
ls
#menampilkan isi dari file yang diunduh
cat Sandbox.csv

less Sandbox.csv
#untuk mengetahui pembeli dengan penjualan yang tertinggi 
awk -F ',' 'NR > 1 {sales[$6] += $17; if (sales[$6] > max_sales) {max_sales = sales[$6]; max_buyer = $6}} END {print max_buyer, max_sales}' Sandbox.csv
#untuk mengetahui pembeli dengan keuntungan yang terendah
awk -F ',' 'NR > 1 { profits[$6] += $20; if (minProfit == "" || profits[$6] < minProfit) minProfit = profits[$6] } END { for (buyer in profits) if (profits[buyer] == minProfit) print buyer, profits[buyer] }' Sandbox.csv
#untuk mengetahui 3 kategori teratas
awk -F ',' 'NR > 1 { sales[$14] += $20 } END { PROCINFO["sorted_in"] = "@val_num_desc"; counter = 0; for (cat in sales) { if (counter < 3) { top_cats[cat] = sales[cat]; counter++ } else { for (top_cat in top_cats) { if (sales[cat] > top_cats[top_cat]) { delete top_cats[top_cat]; top_cats[cat] = sales[cat]; break } } } } for (cat in top_cats) print cat, top_cats[cat] }' Sandbox.csv
 #untuk mengetahui andriaens atau mencari pembeli dengan nama tersebut
 grep 'adriaens' Sandbox.csv | awk -F ',' '{print $2, $6, $17}'
 awk '/Adriaens/ {print}' Sandbox.csv
grep 'Adriaens' Sandbox.csv | awk -F ',' '{print $2, $6, $17}'
