# Feature List

## 1. Fitur Utama
### 1.1 Customer Tracking Form
- Input nomor polisi
- Input 4 digit terakhir no HP
- Tombol "Lacak Status"
- Pencocokan data lewat konektor Google Sheets
- Pesan yang jelas jika data tidak ditemukan atau layanan data bermasalah

### 1.2 Status Dashboard Pelanggan
- Informasi minimum untuk mengenali order (misalnya nomor polisi dan jenis/model kendaraan jika tersedia)
- Nomor polisi
- Status servis saat ini
- Catatan publik dan waktu pembaruan jika tersedia
- Timeline hanya jika histori perubahan memang tersedia di spreadsheet
- Estimasi waktu penyelesaian (opsional)

### 1.3 Label Status yang Dapat Ditampilkan
Label berikut dipakai bila tersedia pada spreadsheet:
- Diterima
- Pemeriksaan awal
- Diagnosa
- Perbaikan
- Menunggu sparepart
- Selesai
- Siap diambil

## 2. Pembaruan Data Operasional
- Staf yang berwenang mengubah status/catatan langsung di spreadsheet yang sudah ada.
- Tidak ada dashboard admin, login staf, manajemen service order, atau fungsi edit di tracker untuk MVP.
- Kolom status, waktu pembaruan, dan catatan publik dipetakan dari spreadsheet sebelum koneksi dibuat.
- Catatan internal tidak ditampilkan kepada pelanggan.

## 3. Fitur Pendukung
- Demo data untuk testing UI
- Responsive layout mobile-friendly
- Konektor baca-saja yang hanya mengembalikan data cocok dan kolom yang diizinkan
- Tampilan keadaan gagal yang jelas jika spreadsheet/konektor tidak tersedia

## 4. Fitur yang Bisa Dikembangkan Selanjutnya
- Panel admin atau pengelolaan status dari aplikasi
- Timeline histori status jika diperlukan dan belum tersedia di spreadsheet
- Chat customer service
- Notifikasi WhatsApp/SMS
- Upload foto proses servis
- Feedback pelanggan
- Integrasi dashboard management bengkel
- Integrasi dengan sistem pembayaran / invoice

## 5. Kesimpulan
MVP adalah halaman tracking pelanggan yang membaca status dari Google Sheets. Staf memperbarui status di spreadsheet; aplikasi tidak memiliki database, backend pengelolaan order, atau panel admin tersendiri.
