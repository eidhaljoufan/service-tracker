# Panduan Interview Kebutuhan — Service Tracker

Panduan ini dipakai untuk menggali kebutuhan aplikasi pelacakan status servis kendaraan. Tujuannya bukan mengonfirmasi asumsi yang sudah tertulis, tetapi memahami proses yang benar-benar berjalan, masalahnya, dan keputusan yang perlu dibuat.

## Cara menggunakan panduan

- Mulai dari cerita kejadian nyata, bukan langsung menawarkan fitur.
- Minta narasumber menjelaskan urutan proses dari awal sampai akhir.
- Tanyakan contoh terakhir yang benar-benar terjadi: siapa melakukan apa, kapan, dan memakai media apa.
- Catat jawaban yang masih berupa asumsi sebagai **perlu dikonfirmasi**, bukan keputusan.
- Pertanyaan bertanda **Prioritas** sebaiknya dijawab sebelum scope MVP disepakati.
- Sesuaikan bagian pertanyaan dengan peran narasumber; tidak perlu menanyakan semuanya ke satu orang.

## 1. Pahami tujuan dan masalah utama

**Prioritas**

1. Apa alasan utama aplikasi ini ingin dibuat sekarang?
2. Masalah paling sering apa yang dialami pelanggan atau tim bengkel terkait informasi status servis?
3. Bisa ceritakan contoh terbaru ketika pelanggan menanyakan progres kendaraannya? Apa yang terjadi dari awal sampai selesai?
4. Siapa yang paling terdampak oleh masalah tersebut, dan seberapa sering masalah itu terjadi?
5. Bagaimana proses yang sama ditangani saat ini—lewat telepon, WhatsApp, spreadsheet, sistem bengkel, atau cara lain?
6. Apa yang ingin berubah setelah aplikasi digunakan? Bagaimana kita tahu aplikasi ini berhasil?
7. Jika untuk versi pertama hanya satu masalah yang bisa dibereskan, masalah mana yang paling penting?

**Probe bila perlu:** jumlah pertanyaan status per hari/minggu, waktu staf yang terpakai, keterlambatan update, keluhan pelanggan, dan dampak ke operasional.

## 2. Petakan proses servis yang sebenarnya

**Prioritas**

1. Tolong ceritakan proses kendaraan dari pertama kali diterima sampai diserahkan kembali ke pelanggan.
2. Di setiap tahap, siapa yang bertanggung jawab dan siapa yang biasanya mengubah status?
3. Apa yang menandakan sebuah tahap sudah dimulai atau benar-benar selesai?
4. Status atau istilah apa yang digunakan tim saat ini? Apakah istilahnya sama antar staf?
5. Apakah semua kendaraan melewati tahapan yang sama? Kalau berbeda, apa contoh jalur lainnya?
6. Kapan kendaraan dianggap **selesai dikerjakan**, dan kapan dianggap **siap diambil**? Apakah dua hal ini berbeda?
7. Dalam kondisi apa pekerjaan menunggu pelanggan, persetujuan biaya, teknisi, atau sparepart?
8. Apa yang dilakukan jika diagnosis berubah, pekerjaan tambahan ditemukan, atau kendaraan kembali ke tahap sebelumnya?
9. Apakah satu kendaraan bisa memiliki lebih dari satu order servis yang aktif pada waktu bersamaan?
10. Informasi apa yang wajib dicatat ketika kendaraan masuk, dan siapa yang mencatatnya?

**Gambar flow kasar saat interview:**

`Pemicu/tahap → siapa yang bertindak → informasi yang dicatat → kondisi lanjut/berhenti → pihak yang perlu diberi tahu`

Minta narasumber mengoreksi flow tersebut sebelum dianggap benar.

## 3. Pertanyaan untuk pelanggan atau pihak yang mewakili pelanggan

1. Biasanya pelanggan mencari tahu status kendaraan lewat kanal apa, dan apa yang terasa merepotkan?
2. Informasi apa yang paling ingin diketahui pelanggan saat membuka tracker?
3. Apakah pelanggan perlu melihat nama, nomor polisi, jenis kendaraan, keluhan, pekerjaan, biaya, atau estimasi selesai? Mana yang tidak boleh ditampilkan?
4. Seberapa sering pelanggan perlu mengecek status? Apakah mereka butuh pemberitahuan saat status berubah?
5. Apa yang sebaiknya pelanggan lakukan jika data tracking tidak ditemukan atau informasinya terlihat salah?
6. Apakah pelanggan perlu menghubungi bengkel langsung dari halaman status? Melalui telepon, WhatsApp, atau kanal lain?
7. Apakah pelanggan biasanya memakai HP dan membuka link dari pesan, atau mencari halaman sendiri?
8. Apakah ada pelanggan yang bukan pemilik kendaraan—misalnya anggota keluarga, sopir, atau perusahaan—yang perlu mengakses status?

## 4. Pertanyaan untuk admin/front desk/service advisor

**Prioritas**

1. Siapa yang menerima kendaraan dan membuat catatan/order servis?
2. Data apa yang sudah dikumpulkan saat penerimaan? Mana yang wajib, opsional, atau sering belum tersedia?
3. Spreadsheet mana yang menjadi sumber status saat ini? Apakah Google Sheets yang sudah dibagikan merupakan sumber data resmi?
4. Bagaimana admin mencari order yang tepat jika pelanggan memiliki beberapa kendaraan atau beberapa kunjungan servis?
5. Siapa yang berhak membuat order, mengubah data, mengubah status, atau menandai kendaraan siap diambil?
6. Apakah perlu menyimpan siapa yang mengubah status dan kapan? Apakah perubahan perlu bisa dikoreksi atau dibatalkan?
7. Informasi apa yang boleh dilihat pelanggan, dan apa yang hanya untuk catatan internal?
8. Perlu catatan publik yang berbeda dari catatan internal? Siapa yang memastikan catatan publik aman dan mudah dipahami?
9. Bagaimana staf mengetahui ada status yang belum diperbarui atau order yang tertahan terlalu lama?
10. Data apa yang diperlukan di daftar kerja harian—misalnya nomor polisi, nama, tanggal masuk, status, teknisi, atau estimasi?

**Probe:** input data lewat ponsel/komputer, kebutuhan pencarian/filter, banyak cabang, pergantian shift, dan prosedur ketika admin salah memilih order.

## 5. Pertanyaan untuk teknisi/mekanik (jika terlibat)

1. Apakah teknisi perlu menggunakan aplikasi, atau update tetap dilakukan melalui admin?
2. Informasi apa yang teknisi butuhkan untuk memahami pekerjaan kendaraan?
3. Pada titik mana teknisi bisa menyatakan pemeriksaan atau perbaikan dimulai/selesai?
4. Apakah teknisi perlu mengirim diagnosis, catatan, foto, kebutuhan sparepart, atau pekerjaan tambahan?
5. Siapa yang menyetujui informasi teknis sebelum ditampilkan kepada pelanggan?
6. Apakah satu order bisa dikerjakan beberapa teknisi atau berpindah penanggung jawab?

## 6. Status, estimasi, dan pemberitahuan

**Prioritas**

1. Status apa saja yang benar-benar diperlukan pada versi pertama? Jelaskan arti setiap status dengan contoh.
2. Status mana yang bisa dipilih admin, dan mana yang harus terjadi otomatis?
3. Apakah transisi status harus berurutan, atau staf boleh langsung melompat ke status tertentu?
4. Apakah perlu status untuk menunggu persetujuan pelanggan, menunggu sparepart, atau pekerjaan ditolak/dibatalkan?
5. Apakah estimasi waktu selesai tersedia dan cukup dapat dipercaya untuk ditampilkan? Siapa yang menetapkan dan memperbaruinya?
6. Apa yang harus terlihat pada timeline: status saja, waktu update, catatan, nama staf, atau foto?
7. Apakah pelanggan perlu diberi tahu saat status berubah? Kanal apa yang digunakan dan siapa yang menanggung biaya/pengelolaannya?
8. Jika notifikasi gagal atau nomor pelanggan salah, apa yang harus dilakukan?

## 7. Akses, verifikasi, dan privasi

**Prioritas**

1. Bagaimana pelanggan seharusnya membuktikan bahwa ia berhak melihat order servis?
2. Apakah memasukkan nomor polisi dan empat digit terakhir nomor HP dianggap cukup aman? Apa risiko jika informasi itu diketahui orang lain?
3. Apakah ada cara verifikasi yang sudah digunakan bengkel, seperti tautan khusus, OTP, atau konfirmasi melalui petugas?
4. Informasi apa yang tidak boleh muncul sebelum verifikasi berhasil?
5. Apa aturan jika nomor HP pelanggan berubah, dipakai bersama, atau tidak tercatat dengan benar?
6. Berapa lama data servis dan histori perlu disimpan? Apakah ada aturan internal atau kewajiban yang harus diikuti?
7. Siapa yang memberikan atau mencabut izin edit spreadsheet ketika akses staf perlu berubah?
8. Apakah izin edit spreadsheet perlu dibatasi berdasarkan peran atau cabang?

## 8. Kasus khusus dan kondisi gagal

Tanyakan mana yang pernah terjadi, mana yang wajib ditangani sejak versi pertama, dan apa tindakan yang diharapkan:

- Nomor polisi atau nomor HP salah ketik.
- Format nomor polisi berbeda-beda atau berubah.
- Data pelanggan/nomor HP tidak lengkap atau tidak cocok.
- Ada beberapa order servis untuk kendaraan yang sama.
- Kendaraan sudah selesai tetapi belum diambil.
- Order dibatalkan, pekerjaan ditolak, atau kendaraan batal masuk bengkel.
- Menunggu persetujuan pelanggan atau sparepart tanpa estimasi yang pasti.
- Status atau catatan terlanjur salah diperbarui.
- Dua staf mengubah order yang sama.
- Internet atau aplikasi tidak tersedia ketika staf perlu memperbarui status.
- Pelanggan melihat informasi yang keliru atau ingin meminta koreksi.

Untuk setiap kasus penting, tanyakan: **siapa yang menangani, apa yang harus dilakukan sistem, dan informasi apa yang perlu dicatat?**

## 9. Batas MVP dan kebutuhan operasional

**Prioritas**

1. Fitur apa yang mutlak diperlukan agar aplikasi bisa dipakai untuk kasus nyata pertama?
2. Fitur apa yang boleh dikerjakan manual dulu atau ditunda?
3. Header/kolom mana di spreadsheet yang memuat nomor polisi, verifikasi pelanggan, status, waktu update, dan catatan?
4. Apakah pelanggan hanya perlu membaca status, sementara staf mengubahnya langsung di spreadsheet?
5. Informasi atau catatan apa yang tidak boleh dikirim ke halaman pelanggan?
6. Siapa saja yang membutuhkan izin edit spreadsheet, dan bagaimana akses tersebut dikelola?
7. Berapa banyak cabang dan order aktif yang perlu didukung pada awal penggunaan?
8. Perangkat apa yang biasa dipakai staf untuk memperbarui spreadsheet?
9. Siapa pemilik spreadsheet dan siapa yang memastikan status tetap terbaru?
10. Apakah ada batasan waktu, anggaran, kebijakan keamanan, atau infrastruktur yang perlu dipatuhi?
11. Siapa yang menyetujui keputusan akhir dan siapa lagi yang harus dilibatkan?

Untuk MVP ini, jangan mengasumsikan staf membutuhkan panel admin baru. Pastikan apakah pembaruan langsung di spreadsheet sudah cukup.

## 10. Kriteria sukses dan validasi

1. Hasil apa yang diharapkan dalam 1–3 bulan setelah aplikasi dipakai?
2. Ukuran apa yang bisa dipakai—misalnya berkurangnya pertanyaan berulang, waktu update status, atau jumlah order dengan status terbaru?
3. Berapa nilai awalnya saat ini, jika sudah diketahui?
4. Skenario apa yang harus berhasil saat demo/pengujian agar solusi dianggap layak?
5. Siapa yang akan mencoba prototype, dan bagaimana cara mengumpulkan masukannya?
6. Data contoh apa yang boleh digunakan untuk pengujian tanpa membocorkan data pelanggan?

## 11. Pertanyaan penutup

- Apa hal penting tentang proses ini yang belum sempat kita bahas?
- Dari hal yang kita bahas, mana yang paling berisiko jika salah dipahami?
- Apakah ada dokumen, formulir penerimaan, contoh chat, spreadsheet, atau sistem yang bisa dijadikan referensi?
- Siapa lagi yang sebaiknya diwawancarai atau dimintai persetujuan?
- Boleh kita kirim rangkuman hasil interview untuk dikonfirmasi sebelum kebutuhan dibakukan?

## Template catatan interview

**Tanggal/waktu:**  
**Nama dan peran narasumber:**  
**Cabang/tim (jika relevan):**  
**Pewawancara:**  

### Masalah dan tujuan
- Masalah utama:
- Dampak/frekuensi:
- Hasil yang diharapkan:
- Ukuran keberhasilan:

### Flow aktual
1. 
2. 
3. 

### Peran dan tanggung jawab
- 

### Data dan aturan bisnis
- Data wajib:
- Sumber data:
- Aturan penting:
- Informasi yang boleh/tidak boleh dilihat pelanggan:

### Kasus khusus
- 

### Keputusan dan hal yang belum pasti
- **Sudah disepakati:**
- **Perlu dikonfirmasi:**
- **Asumsi yang harus divalidasi:**

### Prioritas
- **MVP wajib:**
- **Bisa ditunda:**
- **Di luar scope saat ini:**

### Tindak lanjut
| Tindakan | Penanggung jawab | Target waktu |
|---|---|---|
|  |  |  |

## Output setelah interview

Sebelum kebutuhan dianggap siap untuk desain atau implementasi, rangkum dan konfirmasikan:

1. Flow aktual per peran, termasuk cabang alur dan kondisi berhenti.
2. Daftar status beserta arti dan aturan perpindahannya.
3. Data yang dicatat, sumber data, dan siapa yang memperbaruinya.
4. Informasi yang tampil ke pelanggan dibandingkan catatan internal.
5. Cara verifikasi pelanggan dan batas akses admin.
6. Daftar scope MVP, yang ditunda, serta pemetaan dan akses spreadsheet yang diperlukan.
7. Kriteria sukses dan skenario penerimaan.
8. Keputusan terbuka, pemilik keputusan, dan target konfirmasinya.
