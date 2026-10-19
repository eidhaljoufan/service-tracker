import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/tracking_api.dart';
import '../models/service_order.dart';

const String kAdvisorWhatsAppNumber = '6285810042115';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key, required this.api});
  final TrackingApi api;

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _loading = false;
  bool _searched = false;
  String? _errorMessage;
  List<ServiceOrder> _orders = const [];

  @override
  void dispose() {
    _plateController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSearch() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _searched = true;
      _errorMessage = null;
      _orders = const [];
    });

    try {
      final result = await widget.api.lookup(
        plate: _plateController.text.trim(),
        phoneLast4: _phoneController.text.trim(),
      );
      if (mounted) setState(() => _orders = result);
    } on TrackingApiException catch (e) {
      if (mounted) setState(() => _errorMessage = e.message);
    } catch (_) {
      if (mounted) {
        setState(() => _errorMessage = 'Terjadi kesalahan tidak terduga.');
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _resetSearch() {
    setState(() {
      _searched = false;
      _errorMessage = null;
      _orders = const [];
    });
  }

  Future<void> _launchWhatsApp({String? nopol}) async {
    final message = nopol != null && nopol.isNotEmpty
        ? 'Halo Service Advisor Plaza Mini Serpong, saya ingin menanyakan status servis kendaraan nopol: $nopol'
        : 'Halo Service Advisor Plaza Mini Serpong, saya ingin menanyakan info servis kendaraan.';

    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse(
      'https://wa.me/$kAdvisorWhatsAppNumber?text=$encodedMessage',
    );

    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $url';
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Tidak dapat membuka WhatsApp. Silakan hubungi $kAdvisorWhatsAppNumber',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isShowingResult =
        _searched && !_loading && _errorMessage == null && _orders.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3EE),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: isShowingResult ? _buildResultView() : _buildSearchView(),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // SEARCH FORM VIEW (Matching Reference Image 1)
  // ==========================================
  Widget _buildSearchView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Dark Header Block
        Container(
          color: const Color(0xFF161719),
          padding: const EdgeInsets.fromLTRB(20, 56, 20, 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'PLAZA MINI SERPONG',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Text(
                    'Service Tracker',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Cek Status Servis\nKendaraan Anda!',
                style: TextStyle(
                  fontSize: 28,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Cek progres servis secara langsung, tanpa perlu telepon bengkel.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Color(0xFFB0B0B0),
                ),
              ),
            ],
          ),
        ),

        // Overlapping White Form Card
        Transform.translate(
          offset: const Offset(0, -32),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFE6E4DD)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Nomor Polisi',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF161719),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _plateController,
                          textCapitalization: TextCapitalization.characters,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: Color(0xFF161719),
                          ),
                          decoration: const InputDecoration(
                            hintText: 'B  1286  NZT',
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Color(0xFFA0A0A0),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                            ),
                          ),
                          validator: (val) => val == null || val.trim().isEmpty
                              ? 'Nomor polisi wajib diisi.'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '4 digit terakhir No. HP',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF161719),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.0,
                            color: Color(0xFF161719),
                          ),
                          decoration: const InputDecoration(
                            hintText: '1  7  2  8',
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Color(0xFFA0A0A0),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2.0,
                            ),
                          ),
                          validator: (val) =>
                              val == null || val.trim().length != 4
                              ? 'Masukkan tepat 4 digit angka.'
                              : null,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Untuk verifikasi, supaya data servis hanya bisa dilihat pemilik.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF757575),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _loading ? null : _handleSearch,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF161719),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: const Color(0xFF161719)
                                .withValues(alpha: 0.6),
                            minimumSize: const Size.fromHeight(52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: _loading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Lacak Status',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Error or Empty State Banner
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  _buildErrorCard(_errorMessage!),
                ] else if (_searched && !_loading && _orders.isEmpty) ...[
                  const SizedBox(height: 16),
                  _buildEmptyCard(),
                ],

                const SizedBox(height: 28),

                // "CARA KERJA" Section
                _buildHowItWorks(),

                const SizedBox(height: 20),

                // WhatsApp Chat Advisor Button
                OutlinedButton.icon(
                  onPressed: () => _launchWhatsApp(),
                  icon: const Icon(
                    Icons.chat_rounded,
                    color: Color(0xFF25D366),
                    size: 20,
                  ),
                  label: const Text(
                    'Chat Service Advisor (WhatsApp)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF161719),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFE6E4DD)),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHowItWorks() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CARA KERJA',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 14),
          _stepRow(
            '1',
            'Masukkan nomor polisi dan 4 digit akhir HP yang terdaftar.',
          ),
          const SizedBox(height: 10),
          _stepRow('2', 'Lihat tahap servis kendaraan Anda secara real-time.'),
          const SizedBox(height: 10),
          _stepRow('3', 'Hubungi service advisor bila perlu informasi lanjut.'),
        ],
      ),
    );
  }

  Widget _stepRow(String num, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          num,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Color(0xFF161719),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF555555),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // RESULT VIEW (Matching Reference Image 2)
  // ==========================================
  Widget _buildResultView() {
    final order = _orders.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Dark Header Block with Back Button & Vehicle Banner
        Container(
          color: const Color(0xFF161719),
          padding: const EdgeInsets.fromLTRB(20, 48, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: _resetSearch,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF242629),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF33363A)),
                      ),
                      child: const Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'PLAZA MINI SERPONG',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Status servis kendaraan',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              if (order.customerName != null &&
                  order.customerName!.isNotEmpty) ...[
                Text(
                  order.customerName!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE0E0E0),
                  ),
                ),
                const SizedBox(height: 8),
              ],

              // License Plate Badge Box
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF161719),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      order.plate,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.8,
                        color: Color(0xFF161719),
                      ),
                    ),
                  ),
                ],
              ),

              if (order.model.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  order.model,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFB0B0B0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),

        // Result Cards Section on Cream Background
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero "STATUS TERKINI" Card (Muted Warm Beige)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFECEAE3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2DFD6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF555555),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'STATUS TERKINI',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      order.status.isEmpty ? 'Proses' : order.status,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF161719),
                      ),
                    ),
                    if (order.issue.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        order.issue,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Detail Cards
              if (order.model.isNotEmpty) ...[
                _buildDetailCard(label: 'Model kendaraan', value: order.model),
                const SizedBox(height: 10),
              ],

              if (order.issue.isNotEmpty) ...[
                _buildDetailCard(
                  label: 'Keluhan / jenis pekerjaan',
                  value: order.issue,
                ),
                const SizedBox(height: 10),
              ],

              // 2-Column Row for Status Pengerjaan & Estimasi Selesai
              Row(
                children: [
                  Expanded(
                    child: _buildDetailCard(
                      label: 'Status pengerjaan',
                      value: order.status.isEmpty ? 'Proses' : order.status,
                    ),
                  ),
                  if (order.estimate != null && order.estimate!.isNotEmpty) ...[
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildDetailCard(
                        label: 'Estimasi selesai',
                        value: order.estimate!,
                      ),
                    ),
                  ],
                ],
              ),

              if (order.handoverDate != null &&
                  order.handoverDate!.isNotEmpty) ...[
                const SizedBox(height: 10),
                _buildDetailCard(
                  label: 'Tanggal penyerahan',
                  value: order.handoverDate!,
                ),
              ],

              if (order.customerNotes != null &&
                  order.customerNotes!.isNotEmpty) ...[
                const SizedBox(height: 10),
                _buildDetailCard(label: 'Catatan', value: order.customerNotes!),
              ],

              const SizedBox(height: 20),

              // WhatsApp Chat Advisor Button
              ElevatedButton.icon(
                onPressed: () => _launchWhatsApp(nopol: order.plate),
                icon: const Icon(Icons.chat_rounded, size: 20),
                label: const Text(
                  'Chat Service Advisor',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
              ),

              const SizedBox(height: 12),

              Center(
                child: TextButton.icon(
                  onPressed: _resetSearch,
                  icon: const Icon(Icons.search_rounded, size: 18),
                  label: const Text('Cek Kendaraan Lain'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF161719),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailCard({required String label, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6E4DD)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF757575),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF161719),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0C2C2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline_rounded, color: Color(0xFFC53030)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF9B2C2C),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6E4DD)),
      ),
      child: Row(
        children: const [
          Icon(Icons.search_off_rounded, color: Color(0xFF757575)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Data tidak ditemukan. Pastikan nomor polisi dan 4 digit terakhir No. HP sudah benar.',
              style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
            ),
          ),
        ],
      ),
    );
  }
}
