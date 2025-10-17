import 'package:flutter/material.dart';
import 'package:jatidiri/widget/app_router.dart'; // Import GoRouter
// Import router (sesuaikan path, misal 'lib/app_router.dart')

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router, // Gunakan router dari app_router.dart
      title: 'Jatidiri App',
      debugShowCheckedModeBanner: false,
      // Opsional: Theme global
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // Jika font digunakan global
      ),
    );
  }
}