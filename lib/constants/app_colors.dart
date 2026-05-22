import 'package:flutter/material.dart';

class AppColors {
  // Core Neon accents (Futuristic Cyberpunk / Dribbble)
  static const Color primary = Color(0xFF00E5FF);      // Neon Cyber Cyan
  static const Color primaryDark = Color(0xFF0052D4);  // Royal Neon Blue
  static const Color primaryLight = Color(0xFF80F3FF); // Bright Cyan Tint

  // Secondary Accents
  static const Color secondary = Color(0xFF7C3AED);    // Royal Purple
  static const Color secondaryLight = Color(0xFFA78BFA); // Light Lavender

  // Immersive Backgrounds
  static const Color background = Color(0xFF060913);   // Ultra Cyber Black
  static const Color surface = Color(0xFF0E1629);      // Deep Slate Navy
  static const Color cardDark = Color(0xFF131F3D);     // Dark Steel Blue
  static const Color overlay = Color(0xFF16254A);      // Brightened Overlay

  // Status alerts
  static const Color success = Color(0xFF00E676);      // Electric Green
  static const Color error = Color(0xFFFF3D00);        // Hot Neon Red
  static const Color warning = Color(0xFFFFC400);      // Vivid Amber
  static const Color info = Color(0xFF00B0FF);         // Vivid Blue

  // High-contrast Typography
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8F9CAE);
  static const Color textTertiary = Color(0xFF5E6D8A);

  // Modern accent variations
  static const Color accent1 = Color(0xFF00E5FF); // Cyan Glow
  static const Color accent2 = Color(0xFF7C3AED); // Purple Glow
  static const Color accent3 = Color(0xFFF50057); // Neon Pink
  static const Color accent4 = Color(0xFF00E676); // Lime Green

  // Ultra Premium Gradients
  static const List<Color> primaryGradient = [
    Color(0xFF00E5FF),
    Color(0xFF0052D4),
  ];

  static const List<Color> premiumGradient = [
    Color(0xFF0052D4),
    Color(0xFF4364F7),
    Color(0xFF6FB1FC),
  ];

  static const List<Color> purpleGradient = [
    Color(0xFF7C3AED),
    Color(0xFFC084FC),
  ];

  static const List<Color> cyberGradient = [
    Color(0xFF060913),
    Color(0xFF0E1629),
  ];

  static const List<Color> cardGradient = [
    Color(0xFF131F3D),
    Color(0xFF0E1629),
  ];

  static const List<Color> neonGlowGradient = [
    Color(0xFF00E5FF),
    Color(0xFF7C3AED),
  ];

  // Glassmorphism translucent colors
  static const Color glassOverlay = Color(0x1AFFFFFF); // Translucent glass base
  static const Color glassBorder = Color(0x33FFFFFF);  // Glass refraction border
}
