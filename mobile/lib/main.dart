import 'package:flutter/material.dart';

import 'features/tracking/data/tracking_api.dart';
import 'features/tracking/presentation/tracking_screen.dart';

const String kDefaultApiUrl =
    'https://script.google.com/macros/s/AKfycbzbO9iu56LocYsrJszoYys_hf_qAitaTCxF4jJUDc7a4jnbQBxnwMchneLNsMpSVj79cw/exec';

void main() {
  runApp(const ServiceTrackerApp());
}

class ServiceTrackerApp extends StatelessWidget {
  const ServiceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plaza Mini Service Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F3EE),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF161719),
          surface: const Color(0xFFFFFFFF),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF6F5F0),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE6E4DD)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE6E4DD)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF161719), width: 1.5),
          ),
        ),
      ),
      home: TrackingScreen(api: TrackingApi(endpoint: kDefaultApiUrl)),
    );
  }
}
