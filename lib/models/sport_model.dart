import 'package:flutter/material.dart';

class SportModel {
  final String name;
  final IconData icon;
  final Color color;
  final String description;

  SportModel({
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
  });

  static List<SportModel> getSports() {
    return [
      SportModel(
        name: 'Cricket',
        icon: Icons.sports_cricket,
        color: const Color(0xFF00E5FF), // Cyber Cyan
        description: 'Join elite cricket tournaments & matches',
      ),
      SportModel(
        name: 'Pickleball',
        icon: Icons.sports_tennis,
        color: const Color(0xFF7C3AED), // Royal Purple
        description: 'Fast-paced pickleball doubles & singles',
      ),
      SportModel(
        name: 'Carrom',
        icon: Icons.blur_circular, // Custom premium coin-like circular icon
        color: const Color(0xFFFF2D55), // Vibrant Neon Pink
        description: 'Elite carrom board strategy & tournaments',
      ),
      SportModel(
        name: 'Badminton',
        icon: Icons.sports, // Badminton matches
        color: const Color(0xFFFFC400), // Vivid Gold
        description: 'Fast shuttle smashes and singles matches',
      ),
    ];
  }
}
