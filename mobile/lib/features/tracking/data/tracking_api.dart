import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/service_order.dart';

class TrackingApiException implements Exception {
  const TrackingApiException(this.message);
  final String message;
  @override
  String toString() => message;
}

class TrackingApi {
  TrackingApi({required this.endpoint, http.Client? client})
    : _client = client ?? http.Client();

  final String endpoint;
  final http.Client _client;

  Future<List<ServiceOrder>> lookup({
    required String plate,
    required String phoneLast4,
  }) async {
    final uri = Uri.tryParse(endpoint);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      throw const TrackingApiException('API URL belum dikonfigurasi.');
    }

    Map<String, dynamic>? payload;

    // Strategy 1: Try POST request (for doPost in Google Apps Script)
    try {
      final initialResponse = await _client
          .post(
            uri,
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode({'plate': plate, 'phoneLast4': phoneLast4}),
          )
          .timeout(const Duration(seconds: 15));

      http.Response targetResponse = initialResponse;

      if (initialResponse.statusCode >= 300 &&
          initialResponse.statusCode < 400) {
        final location = initialResponse.headers['location'];
        if (location != null && location.isNotEmpty) {
          if (location.contains('accounts.google.com') ||
              location.contains('ServiceLogin')) {
            throw const TrackingApiException(
              'Akses Google Apps Script belum dibuka. Pastikan setelan Akses (Who has access) di Google Apps Script diatur ke "Siapa saja" (Anyone).',
            );
          }
          targetResponse = await _client
              .get(uri.resolve(location))
              .timeout(const Duration(seconds: 15));
        }
      }

      if (targetResponse.statusCode == 200) {
        final decoded = jsonDecode(targetResponse.body);
        if (decoded is Map<String, dynamic>) {
          payload = decoded;
        }
      }
    } catch (e) {
      if (e is TrackingApiException) rethrow;
      // Fall through to Strategy 2
    }

    // Strategy 2: If Strategy 1 didn't yield a valid JSON payload, try GET with query parameters (for doGet)
    if (payload == null) {
      try {
        final queryUri = uri.replace(
          queryParameters: {
            ...uri.queryParameters,
            'plate': plate,
            'phoneLast4': phoneLast4,
          },
        );
        final getResponse = await _client
            .get(queryUri)
            .timeout(const Duration(seconds: 15));

        if (getResponse.statusCode == 200) {
          final decoded = jsonDecode(getResponse.body);
          if (decoded is Map<String, dynamic>) {
            payload = decoded;
          }
        }
      } on TimeoutException {
        throw const TrackingApiException(
          'Permintaan timeout. Periksa koneksi Anda.',
        );
      } on http.ClientException {
        throw const TrackingApiException('Gagal terhubung ke server.');
      } catch (_) {
        // Fall through
      }
    }

    if (payload == null) {
      throw const TrackingApiException(
        'Format respons server tidak valid. Pastikan Google Apps Script mengembalikan JSON.',
      );
    }

    if (payload['ok'] != true) {
      final msg = payload['error']?.toString();
      throw TrackingApiException(msg ?? 'Data servis tidak ditemukan.');
    }

    final rawMatches = payload['matches'];
    if (rawMatches is! List) {
      return const [];
    }

    return rawMatches
        .whereType<Map<String, dynamic>>()
        .map(ServiceOrder.fromJson)
        .toList(growable: false);
  }
}
