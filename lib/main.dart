import 'package:absensi_siswa/view/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      // encountering error dirt materialapp on web browser
      supportedLocales: const [
        Locale('en', ''),
      ],
      theme: ThemeData(
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.white,
              onPrimary: Colors.black,
              secondary: Colors.blue,
              onSecondary: Colors.blue,
              error: Colors.red,
              onError: Colors.red,
              surface: Colors.blue,
              onSurface: Colors.white)),
      home: const LoginPage(),
    );
  }
}
