# Plaza Mini Serpong Service Tracker 🛠️🚘

## 1. Ringkasan Proyek 📝
Proyek ini adalah prototype halaman web mobile-friendly agar pelanggan Plaza Mini Serpong dapat mengecek status servis kendaraannya. Untuk MVP, data status menggunakan Google Sheets yang sudah dipakai sebagai sumber data; staf memperbarui status langsung di spreadsheet, bukan melalui panel admin baru.

Arah pengembangan aplikasi berfokus pada tampilan mobile, baik dari android maupun iOS. Untuk tahapan awal dimulai pengembangan pada android terlebih dahulu dengan bahasa Kotlin dan akan dilanjutkan pengembangan aplikasi iOS dengan bahasa Swift

## 2. Tujuan Proyek
- Memudahkan pelanggan mengecek status servis secara mandiri
- Mengurangi pertanyaan status berulang melalui telepon atau chat
- Memakai spreadsheet yang sudah tersedia agar MVP tidak membutuhkan database dan aplikasi full-stack terpisah

## 3. Pengguna dan Batas MVP
### Pelanggan
Memasukkan nomor polisi dan empat digit terakhir nomor HP yang terdaftar untuk melihat status servis yang cocok.

### Staf bengkel
Memperbarui status dan catatan yang boleh dilihat pelanggan langsung di Google Sheets menggunakan akses Google yang sudah diberikan.

MVP tidak mencakup login staf, panel admin, pengelolaan order dari aplikasi, database terpisah, notifikasi otomatis, atau histori status lengkap kecuali data histori memang sudah tersedia di spreadsheet.

## 4. Sumber Data dan Alur Utama
Sumber data menggunakan Google Sheets yang sudah tersedia.

Alur MVP:
1. Staf yang berwenang mengubah status/catatan order di spreadsheet.
2. Pelanggan membuka halaman tracker dan mengisi nomor polisi serta empat digit terakhir nomor HP.
3. Konektor membaca dan mencocokkan data di sisi server, lalu mengembalikan hanya informasi publik untuk order yang cocok.
4. Halaman menampilkan status terkini dan waktu pembaruan jika tersedia.

Spreadsheet tidak boleh dipublikasikan seluruhnya ke web. Koneksi perlu membatasi akses pada hasil yang cocok dan kolom yang memang boleh dilihat pelanggan. Nama kolom yang ada harus dipetakan sebelum implementasi; struktur spreadsheet tidak diasumsikan.

## 5. Struktur Folder Proyek
- `README.md` — ringkasan umum proyek
- `docs/requirements.md` — kebutuhan bisnis dan teknis
- `docs/feature-list.md` — daftar fitur
- `docs/user-flow.md` — alur pelanggan dan staf
- `docs/data-model.md` — kebutuhan pemetaan data spreadsheet

## 6. Nama Proyek yang Direkomendasikan
Nama yang paling cocok untuk proyek ini:
- `plaza-mini-serpong-service-tracker`

Alias singkat yang bisa dipakai:
- `PMSS Tracker`
- `Service Tracker Plaza Mini`
- `Plaza Mini Service Portal`

## 7. Kesimpulan Singkat
MVP berfokus pada halaman cek status yang membaca data dari Google Sheets. Spreadsheet tetap menjadi tempat staf mengelola pembaruan; solusi tidak membangun database atau panel admin tersendiri.

---

Dokumentasi lebih lengkap ada di folder `docs/`.
