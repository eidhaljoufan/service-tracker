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

    http.Response? response;

    // Strategy 1: Try POST request (for doPost in Google Apps Script)
    try {
      final initialResponse = await _client
          .post(
            uri,
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode({'plate': plate, 'phoneLast4': phoneLast4}),
          )
          .timeout(const Duration(seconds: 15));

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
          // Google Apps Script redirects POST results to script.googleusercontent.com,
          // which MUST be fetched via GET (POST to redirected URL returns HTTP 405).
          response = await _client
              .get(uri.resolve(location))
              .timeout(const Duration(seconds: 15));
        }
      } else if (initialResponse.statusCode == 200) {
        response = initialResponse;
      }
    } catch (e) {
      if (e is TrackingApiException) rethrow;
      // Fall through to Strategy 2
    }

    // Strategy 2: Fallback to GET request with query parameters (for doGet in Google Apps Script)
    if (response == null || response.statusCode != 200) {
      try {
        final queryUri = uri.replace(
          queryParameters: {
            ...uri.queryParameters,
            'plate': plate,
            'phoneLast4': phoneLast4,
          },
        );
        response = await _client
            .get(queryUri)
            .timeout(const Duration(seconds: 15));
      } on TimeoutException {
        throw const TrackingApiException(
          'Permintaan timeout. Periksa koneksi Anda.',
        );
      } on http.ClientException {
        throw const TrackingApiException('Gagal terhubung ke server.');
      }
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw TrackingApiException(
        'Layanan bermasalah (HTTP ${response.statusCode}).',
      );
    }

    late final Map<String, dynamic> payload;
    try {
      payload = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw const TrackingApiException('Format respons server tidak valid.');
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
