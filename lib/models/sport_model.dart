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
        color: const Color(0xFF4CAF50),
        description: 'Join cricket tournaments and matches',
      ),
      SportModel(
        name: 'Pickleball',
        icon: Icons.sports_tennis,
        color: const Color(0xFF2196F3),
        description: 'Fast-paced pickleball action',
      ),
      SportModel(
        name: 'Football',
        icon: Icons.sports_soccer,
        color: const Color(0xFF9C27B0),
        description: 'Experience the beautiful game',
      ),
      SportModel(
        name: 'Badminton',
        icon: Icons.sports,
        color: const Color(0xFFFF9800),
        description: 'Smash your way to victory',
      ),
    ];
  }
}
