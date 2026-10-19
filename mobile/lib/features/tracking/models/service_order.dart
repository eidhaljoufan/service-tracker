class ServiceOrder {
  const ServiceOrder({
    required this.plate,
    required this.issue,
    required this.status,
    this.customerName,
    this.phone,
    this.timeIn,
    this.technician,
    this.estimate,
    this.customerNotes,
    this.model,
    this.handoverDate,
  });

  final String plate;
  final String issue;
  final String status;
  final String? customerName;
  final String? phone;
  final String? timeIn;
  final String? technician;
  final String? estimate;
  final String? customerNotes;
  final String? model;
  final String? handoverDate;

  factory ServiceOrder.fromJson(Map<String, dynamic> json) {
    String read(List<String> keys) {
      for (final k in keys) {
        if (json.containsKey(k) && json[k] != null) {
          final val = json[k].toString().trim();
          if (val.isNotEmpty) return val;
        }
      }
      return '';
    }

    String? optional(List<String> keys) {
      final val = read(keys);
      return val.isEmpty ? null : val;
    }

    return ServiceOrder(
      plate: read(['plate', 'noPolisi', 'noPol', 'No. Polisi', 'No Polisi', 'no_polisi']),
      issue: read(['issue', 'keluhan', 'jenisPekerjaan', 'Keluhan / jenis Pekerjaan', 'Keluhan', 'keluhan_jenis_pekerjaan']),
      status: read(['status', 'statusPengerjaan', 'Status Pengerjaan', 'Status', 'status_pengerjaan']),
      customerName: optional(['customerName', 'namaPelanggan', 'Nama Pelanggan', 'customer', 'name', 'nama_pelanggan']),
      phone: optional(['phone', 'noHp', 'No. HP', 'No HP', 'no_hp']),
      timeIn: optional(['timeIn', 'jamMasuk', 'Jam Masuk', 'jam_masuk']),
      technician: optional(['technician', 'namaTeknisi', 'Nama Teknisi', 'teknisi', 'nama_teknisi']),
      estimate: optional(['estimate', 'estimasiSelesai', 'Estimasi Selesai', 'estimasi', 'estimasi_selesai']),
      customerNotes: optional(['customerNotes', 'catatanTambahan', 'Catatan Tambahan', 'catatan', 'notes', 'catatan_tambahan']),
      model: optional(['model', 'modelKendaraan', 'Model Kendaraan', 'model_kendaraan']),
      handoverDate: optional(['handoverDate', 'tanggalPenyerahan', 'Tanggal Penyerahan', 'tanggal_penyerahan']),
    );
  }
}
