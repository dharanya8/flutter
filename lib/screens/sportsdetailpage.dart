import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/modern_button.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_styles.dart';
import 'register_screen.dart';
import '../models/sport_model.dart';

class SportsDetailPage extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  final String time;
  final String venue;
  final String img;

  const SportsDetailPage({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
    required this.time,
    required this.venue,
    required this.img,
  });

  String get amount {
    if (title.toLowerCase().contains('cricket')) {
      return "₹1500";
    }
    return "₹500";
  }

  String get aboutSport {
    if (title.toLowerCase().contains('cricket')) {
      return "Cricket is one of the most popular team sports played with bat and ball. Enjoy thrilling matches and exciting tournaments with top-class facilities and professional coaching.";
    }
    if (title.toLowerCase().contains('pickleball')) {
      return "Pickleball is a fast-growing paddle sport combining elements of tennis, badminton, and table tennis. Perfect for all age groups and skill levels.";
    }
    if (title.toLowerCase().contains('carrom')) {
      return "Carrom is an indoor strategy game requiring focus, precision, and tactical thinking. A timeless classic for sports enthusiasts.";
    }
    if (title.toLowerCase().contains('badminton')) {
      return "Badminton is a high-speed racket sport played with a shuttlecock. Combines agility, speed, and precision for an exciting competition.";
    }
    return "Enjoy exciting sports tournaments with professional organization and top venues.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero image section
                Stack(
                  children: [
                    Container(
                      height: 320,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(img),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      height: 320,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.9),
                          ],
                        ),
                      ),
                    ),
                    // Back button
                    Positioned(
                      top: 50,
                      left: 16,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    // Title section
                    Positioned(
                      bottom: 24,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusMd,
                              ),
                            ),
                            child: Text(
                              'Tournament',
                              style: GoogleFonts.poppins(
                                color: AppColors.accent1,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                // About tournament section
                _buildSection('About Tournament', desc),
                // About sport section
                _buildSection('About the Event', aboutSport),
                // Event details section
                _buildDetailsSection(),
                const SizedBox(height: AppSpacing.xxxl),
              ],
            ),
          ),
          // Register button at bottom
          Positioned(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: AppSpacing.lg,
            child: ModernButton(
              text: 'Register Now • $amount',
              onPressed: () {
                // Find the sport from title
                final sports = SportModel.getSports();
                final sport = sports.firstWhere(
                  (s) => title.toLowerCase().contains(s.name.toLowerCase()),
                  orElse: () => sports[0],
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegisterScreen(sport: sport),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            child: Text(
              content,
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.8,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event Details',
            style: GoogleFonts.poppins(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildDetailCard(Icons.calendar_today, 'Date', date),
          const SizedBox(height: AppSpacing.md),
          _buildDetailCard(Icons.access_time, 'Time', time),
          const SizedBox(height: AppSpacing.md),
          _buildDetailCard(Icons.location_on, 'Venue', venue),
          const SizedBox(height: AppSpacing.md),
          _buildDetailCard(Icons.currency_rupee, 'Registration Fee', amount),
        ],
      ),
    );
  }

  Widget _buildDetailCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surface.withOpacity(0.2),
            AppColors.cardDark.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: AppSpacing.iconMedium,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

  // 💰 Amount
  String get amount {
    if (data["sport"] == "Cricket") {
      return "₹1500";
    }
    return "₹500";
  }

  // 📄 About Sports
  String get aboutSport {
    String sport = data["sport"]!;

    if (sport == "Cricket") {
      return "Cricket is one of the most popular team sports played with bat and ball. Enjoy thrilling matches and exciting tournaments.";
    }

    if (sport == "Pickleball") {
      return "Pickleball is a fast growing paddle sport combining tennis, badminton and table tennis.";
    }

    if (sport == "Carrom") {
      return "Carrom is an indoor strategy game requiring focus and precision.";
    }

    if (sport == "Badminton") {
      return "Badminton is a high-speed racket sport played with shuttlecock.";
    }

    return "Enjoy exciting sports tournaments.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081221),

      body: Stack(
        children: [
          // 🔥 MAIN CONTENT
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼 TOP IMAGE
                Stack(
                  children: [
                    Container(
                      height: 320,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(data["img"]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Container(
                      height: 320,

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,

                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.9),
                          ],
                        ),
                      ),
                    ),

                    // 🔙 BACK BUTTON
                    Positioned(
                      top: 50,
                      left: 15,

                      child: CircleAvatar(
                        backgroundColor: Colors.black45,

                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // 🏆 TITLE
                    Positioned(
                      bottom: 30,
                      left: 20,
                      right: 20,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            data["sport"]!,

                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            data["title"]!,

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // 📄 ABOUT TOURNAMENT
                _sectionTitle("About Tournament"),

                _modernCard(
                  child: Text(
                    data["desc"]!,

                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.7,
                    ),
                  ),
                ),

                // 🏏 ABOUT SPORT
                _sectionTitle("About ${data["sport"]}"),

                _modernCard(
                  child: Text(
                    aboutSport,

                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.7,
                    ),
                  ),
                ),

                // 📅 EVENT DETAILS
                _sectionTitle("Event Details"),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  child: Column(
                    children: [
                      _detailCard(Icons.calendar_month, "Date", data["date"]!),

                      const SizedBox(height: 12),

                      _detailCard(Icons.access_time, "Time", data["time"]!),

                      const SizedBox(height: 12),

                      _detailCard(Icons.location_on, "Venue", data["venue"]!),

                      const SizedBox(height: 12),

                      _detailCard(
                        Icons.currency_rupee,
                        "Registration Amount",
                        amount,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),

          // 🔥 REGISTER BUTTON
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: SizedBox(
              height: 60,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SuccessPage(
                        sport: data["sport"]!,
                        amount: amount,
                        venue: data["venue"]!,
                        date: data["date"]!,
                        time: data["time"]!,
                      ),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 10,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                child: Text(
                  "Register Now • $amount",

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 SECTION TITLE
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Text(
        title,

        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 🔹 MODERN CARD
  Widget _modernCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),

        borderRadius: BorderRadius.circular(22),

        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),

      child: child,
    );
  }

  // 🔹 DETAIL CARD
  Widget _detailCard(IconData icon, String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.withOpacity(0.2),

            child: Icon(icon, color: Colors.blueAccent),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),

                const SizedBox(height: 5),

                Text(
                  value,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
