# Requirements Document

## 1. Tujuan Bisnis
Membantu pelanggan mengecek status kendaraan servis secara mandiri melalui halaman web yang membaca data dari Google Sheets yang sudah tersedia. Staf memperbarui status langsung di spreadsheet. MVP sengaja tidak membangun database, panel admin, atau sistem full-stack terpisah.

Spreadsheet sumber data: Google Sheets.

## 2. Masalah yang Diselesaikan
- Pelanggan tidak tahu status kendaraan saat sedang servis
- Bengkel harus menjawab pertanyaan berulang dari banyak pelanggan
- Proses update status sering tidak terdokumentasi dengan baik
- Pelanggan belum memiliki cara mandiri untuk melihat status terbaru dari data yang dicatat staf

## 3. User Needs
### Customer
- ingin melihat status kendaraan dengan cepat
- ingin tahu apakah proses servis sudah mulai, menunggu sparepart, atau selesai
- ingin memastikan data servis hanya bisa diakses oleh pemilik yang berhak

### Admin Bengkel
- ingin tetap memperbarui status melalui spreadsheet yang sudah digunakan
- tidak perlu mengelola panel admin baru untuk MVP

## 4. Functional Requirements
### 4.1 Customer Tracking
- Customer dapat memasukkan nomor polisi
- Customer dapat memasukkan 4 digit terakhir nomor HP
- Sistem mencocokkan input dengan data di Google Sheets melalui konektor ringan (misalnya Google Apps Script) yang tidak mengekspos seluruh isi spreadsheet
- Jika valid, sistem hanya menampilkan status dan informasi servis yang diizinkan untuk pelanggan
- Jika tidak valid, sistem menampilkan pesan error / data tidak ditemukan

### 4.2 Status Servis di Spreadsheet
Staf memperbarui status langsung pada baris/order terkait di spreadsheet. Nilai status yang ditampilkan tracker mengikuti data di spreadsheet dan menggunakan istilah yang disepakati:
- Diterima / masuk bengkel
- Pemeriksaan awal
- Diagnosis / inspeksi
- Proses perbaikan
- Menunggu sparepart
- Selesai / siap diambil
- Ditolak / belum bisa dikerjakan (opsional)

### 4.3 Informasi yang Ditampilkan
- Status servis terkini
- Waktu pembaruan dan catatan status jika tersedia dan disetujui untuk dilihat pelanggan
- Informasi kendaraan/order minimum yang diperlukan untuk memastikan hasil pencarian benar
- Timeline hanya ditampilkan apabila spreadsheet menyediakan histori perubahan; MVP tidak membuat log terpisah

### 4.4 Data Spreadsheet
Kolom yang sudah tersedia harus diperiksa dan dipetakan sebelum integrasi. Secara fungsional, data perlu menyediakan:
- penanda order/kunjungan servis agar order aktif untuk kendaraan yang sama dapat dibedakan
- nomor polisi untuk pencocokan
- data verifikasi nomor HP (sebaiknya empat digit terakhir, bukan nomor lengkap yang dikembalikan ke klien)
- status terkini
- waktu pembaruan dan catatan publik bila tersedia

### 4.5 Pembaruan oleh Staf
- Staf yang memiliki izin Google Sheets mengubah status/catatan langsung di spreadsheet.
- Tracker bersifat baca-saja; tidak ada login admin atau fungsi edit status di halaman.
- Mekanisme konektor ringan dan pemetaan kolom dikonfirmasi sebelum implementasi; tidak perlu membuat backend aplikasi atau database terpisah.

## 5. Non-Functional Requirements
### 5.1 Keamanan
- Spreadsheet tidak boleh dipublikasikan secara keseluruhan atau dikirim utuh ke browser.
- Konektor hanya mengembalikan data yang cocok dan kolom yang disetujui untuk pelanggan.
- Pencocokan menggunakan nomor polisi + empat digit terakhir nomor HP; kombinasi ini adalah verifikasi dasar dan tidak boleh dianggap sebagai perlindungan kuat untuk data sensitif.
- Akses edit spreadsheet dibatasi melalui izin Google kepada staf yang berwenang.
- Nomor HP lengkap, catatan internal, dan informasi sensitif lain tidak ditampilkan kepada pelanggan.

### 5.2 Usability
- Interface mudah digunakan oleh customer umum
- Layout mobile-friendly
- Proses tracking harus cepat dan jelas

### 5.3 Performance
- Waktu respons saat validasi data harus cepat
- Halaman status harus bisa dibuka dari perangkat mobile

### 5.4 Maintainability
- Spreadsheet tetap menjadi sumber data utama untuk MVP; hindari salinan database yang harus disinkronkan.
- Nama kolom dan nilai status harus dipetakan secara eksplisit agar perubahan sheet tidak diam-diam merusak pencarian.

## 6. Business Rules
- Satu baris/order aktif harus dapat dibedakan dari kunjungan servis lain untuk kendaraan yang sama.
- Status di spreadsheet adalah status terkini dan menjadi sumber kebenaran tracker.
- Data pelanggan hanya dikembalikan setelah kombinasi verifikasi cocok.
- Hanya informasi yang disetujui untuk publik yang boleh ditampilkan; catatan internal tetap di spreadsheet.
- Staf mengelola data dan status melalui spreadsheet sesuai izin Google yang diberikan.

## 7. Acceptance Criteria
### Scenario 1: Customer valid
- Customer menginput nomor polisi + 4 digit terakhir HP yang sesuai
- Sistem menampilkan data kendaraan dan status servis
- Status muncul secara jelas dan mudah dibaca

### Scenario 2: Customer tidak valid
- Customer menginput data yang tidak cocok
- Sistem menolak akses dan menampilkan notifikasi bahwa data tidak ditemukan

### Scenario 3: Staf update spreadsheet
- Staf yang berwenang mengubah status order di Google Sheets
- Pelanggan yang mencari order tersebut melihat status terbaru dari sumber data yang sama
- Tracker tidak mengharuskan staf login ke panel admin aplikasi

## 8. Scope MVP
Berikut fitur utama yang masuk ke MVP:
- form tracking customer
- validasi nomor polisi + 4 digit HP
- halaman status servis
- koneksi baca-saja ke Google Sheets
- update status dilakukan staf langsung di Google Sheets
- menampilkan waktu/catatan status dan timeline hanya jika datanya tersedia serta disetujui untuk pelanggan

## 9. Scope Future / Enhancement
- panel admin dan database tersendiri
- histori status terpisah/timeline lengkap jika belum disediakan spreadsheet
- notifikasi WhatsApp / SMS otomatis
- foto progress servis
- dashboard analitik bengkel
- riwayat servis pelanggan
- review pelanggan setelah servis selesai
- integrasi dengan sistem ERP / POS bengkel
