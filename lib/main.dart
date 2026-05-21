import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'constants/app_theme.dart';

void main() {
  runApp(const ToToSportsApp());
}

class ToToSportsApp extends StatelessWidget {
  const ToToSportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToTo Sports',
      theme: AppTheme.darkTheme(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
