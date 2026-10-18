# Data Model MVP

## 1. Sumber Data
MVP menggunakan Google Sheets yang sudah diberikan sebagai sumber data tunggal.

Dokumen ini tidak menetapkan ulang skema atau membuat database. Sebelum integrasi, periksa nama tab dan header yang memang ada, lalu petakan kolom yang tersedia. Jangan mengubah atau menghapus kolom sheet sebelum disepakati dengan pemiliknya.

## 2. Kolom yang Dibutuhkan atau Dipetakan
- **Identitas order:** ID order atau penanda lain untuk membedakan beberapa kunjungan servis kendaraan yang sama.
- **Nomor polisi:** dipakai untuk pencarian, dengan normalisasi format yang disepakati.
- **Verifikasi pelanggan:** empat digit terakhir nomor HP yang terdaftar. Jangan mengirim nomor HP lengkap ke browser.
- **Status terkini:** satu nilai status yang ditampilkan kepada pelanggan.
- **Waktu update:** tanggal/waktu perubahan status terakhir, jika tersedia.
- **Catatan publik:** keterangan yang sudah disetujui untuk pelanggan, jika tersedia; pisahkan dari catatan internal.
- **Info tampilan opsional:** model kendaraan, tanggal masuk, atau estimasi selesai bila kolom tersedia dan disetujui untuk ditampilkan.

Pemetaan kolom aktual dan nilai status harus dikonfirmasi sebelum implementasi. Tracker membaca data saja melalui konektor ringan (misalnya Google Apps Script); staf memperbarui spreadsheet secara langsung. Tidak perlu membuat database atau backend aplikasi terpisah.

## 3. Nilai Status yang Disarankan
- `received` — diterima / masuk bengkel
- `checking` — pemeriksaan awal
- `diagnosis` — diagnosis / inspeksi
- `in_progress` — proses perbaikan
- `waiting_part` — menunggu sparepart
- `completed` — selesai / siap diambil
- `rejected` — ditolak / belum bisa dikerjakan (opsional)

Nilai aktual pada spreadsheet boleh menggunakan label Bahasa Indonesia; konektor memetakan label tersebut ke tampilan yang konsisten tanpa mengharuskan perubahan data lama.

## 4. Akses dan Privasi
- Jangan membuat link publik untuk seluruh spreadsheet.
- Konektor hanya mencari order yang cocok di sisi server dan mengembalikan kolom yang disetujui untuk order tersebut.
- Berikan izin edit spreadsheet hanya kepada staf yang berwenang.
- Empat digit terakhir nomor HP bersama nomor polisi hanya merupakan verifikasi dasar; jangan tampilkan data pribadi atau sensitif berdasarkan verifikasi ini.
- Jika endpoint atau izin spreadsheet gagal, tracker menampilkan keadaan gagal yang jelas dan tidak menganggap pencarian berhasil.
