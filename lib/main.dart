import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

void main() {
  runApp(const ToToSportsApp());
}

class ToToSportsApp extends StatelessWidget {
  const ToToSportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToTo Sports',
      theme: ThemeData.dark().copyWith(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.primary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
