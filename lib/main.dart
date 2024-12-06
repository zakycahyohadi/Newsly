import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:api_news/presentation/home_page/home_page.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Ubah ke false untuk menonaktifkan Device Preview
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true, // Tambahkan ini agar mendukung DevicePreview
      locale: DevicePreview.locale(context), // Locale mengikuti DevicePreview
      builder: DevicePreview.appBuilder, // Tambahkan builder dari DevicePreview
      home: const HomePage(),
    );
  }
}
