# User Flow

## 1. Alur Pelanggan
### A. Membuka Halaman Tracker
- User membuka halaman utama
- User melihat judul: "Mobil Anda lagi diapain, ya?"
- User melihat form tracking

### B. Input Data
- User memasukkan nomor polisi, contoh: `B 1286 NZT`
- User memasukkan 4 digit terakhir nomor HP
- User menekan tombol `Lacak Status`

### C. Validasi
- Konektor membaca/mencocokkan data di Google Sheets dengan nomor polisi dan empat digit terakhir nomor HP
- Jika cocok, sistem hanya mengembalikan informasi order yang diizinkan untuk pelanggan
- Jika tidak cocok, sistem menampilkan pesan: data tidak ditemukan atau data tidak valid
- Jika spreadsheet/konektor tidak tersedia, sistem memberi tahu bahwa status belum dapat dimuat dan tidak menampilkan data lama seolah-olah terbaru

### D. Melihat Status Servis
- User melihat status kendaraan saat ini
- User melihat waktu pembaruan dan catatan publik jika tersedia
- User dapat melihat timeline hanya jika spreadsheet menyediakan histori perubahan
- User hanya melihat informasi kendaraan/order yang disetujui untuk pelanggan

## 2. Alur Pembaruan Status oleh Staf
### A. Update status di spreadsheet
- Staf dengan izin Google membuka spreadsheet sumber
- Staf menemukan baris/order yang benar dan mengubah status serta waktu/catatan publik bila kolom tersebut tersedia
- Perubahan pada sumber data akan dibaca oleh tracker saat pelanggan melakukan pencarian berikutnya

Tidak ada login atau dashboard admin terpisah pada MVP.

## 3. Flow Diagram Ringkas
Staf -> Buka Google Sheets -> Update status order
Customer -> Input nomor polisi + 4 digit HP -> Konektor mencocokkan di Sheets -> Status yang diizinkan tampil

## 4. Edge Cases
- Nomor polisi typo
- Nomor HP salah 4 digit terakhir
- Kendaraan/order tidak ditemukan di spreadsheet
- Banyak kendaraan dengan pelanggan yang sama
- Ada beberapa order servis untuk nomor polisi yang sama
- Kendaraan sudah selesai tapi status belum diperbarui
- Spreadsheet atau konektor tidak dapat diakses
- Data cocok, tetapi kolom opsional (misalnya waktu update atau catatan) kosong

## 5. Catatan UX
UI harus memberikan feedback yang jelas:
- validasi gagal harus jelas
- status servis harus mudah dibaca
- warna status bisa dibedakan: pending, proses, selesai
- tombol CTA harus terlihat jelas dan tidak membingungkan
- jika data tidak dapat dimuat dari spreadsheet, tampilkan kondisi gagal dan sediakan cara untuk menghubungi bengkel
