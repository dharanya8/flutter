import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/login_screen.dart';
import '../widgets/modern_button.dart';
import '../widgets/glass_container.dart';
import '../widgets/custom_textfield.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_styles.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String phone;

  const ProfileScreen({super.key, required this.name, required this.phone});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _phoneController = TextEditingController(text: widget.phone);
  }

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(AppSpacing.lg),
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(AppSpacing.xl),
              child: GlassContainer(
                padding: const EdgeInsets.all(AppSpacing.xl),
                margin: EdgeInsets.zero,
                borderRadius: 24,
                blurValue: 16,
                borderColor: AppColors.error.withOpacity(0.3),
                borderWidth: 1.5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.error.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.power_settings_new_rounded,
                        color: AppColors.error,
                        size: 38,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'TERMINATE SESSION',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Are you sure you want to log out of your ToTo Sports account?',
                      style: GoogleFonts.poppins(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      children: [
                        Expanded(
                          child: ModernButton(
                            text: 'CANCEL',
                            onPressed: () => Navigator.pop(dialogContext),
                            isOutlined: true,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: ModernButton(
                            text: 'LOGOUT',
                            onPressed: () {
                              Navigator.pop(dialogContext); // Close dialog
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            gradientColors: [
                              AppColors.error,
                              AppColors.error.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.08),
                width: 1.2,
              ),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        title: Text(
          'Athlete Profile',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_isEditing) {
                if (_nameController.text.trim().isEmpty) {
                  _showSnackbar('Name cannot be empty', isError: true);
                  return;
                }
                if (_phoneController.text.trim().length != 10) {
                  _showSnackbar(
                    'Phone number must be 10 digits',
                    isError: true,
                  );
                  return;
                }
                _showSnackbar('Profile details updated!');
              }
              setState(() => _isEditing = !_isEditing);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _isEditing
                    ? AppColors.success.withOpacity(0.12)
                    : AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isEditing
                      ? AppColors.success.withOpacity(0.3)
                      : AppColors.primary.withOpacity(0.3),
                  width: 1.2,
                ),
              ),
              child: Text(
                _isEditing ? 'SAVE' : 'EDIT',
                style: GoogleFonts.poppins(
                  color: _isEditing ? AppColors.success : AppColors.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Cyber ambient neon glow background
          Positioned(
            top: 40,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 120,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.xl),

                  // Glowing avatar frame
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: AppColors.neonGlowGradient,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.25),
                                blurRadius: 25,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: CircleAvatar(
                              radius: 61,
                              backgroundColor: AppColors.background,
                              child: Icon(
                                Icons.sports_motorsports_outlined,
                                size: 55,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.background,
                                width: 2.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.verified_user_rounded,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  Text(
                    _nameController.text.toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'VERIFIED TOTO ATHLETE',
                    style: GoogleFonts.poppins(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Form fields inside premium glass container
                  GlassContainer(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    margin: EdgeInsets.zero,
                    borderRadius: 26,
                    blurValue: 15,
                    borderColor: Colors.white.withOpacity(0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'ATHLETE BIO DATA',
                          style: GoogleFonts.poppins(
                            color: AppColors.textTertiary,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        // Full Name Input / Text
                        if (_isEditing) ...[
                          CustomTextField(
                            controller: _nameController,
                            label: 'Full Name',
                            hint: 'Edit name',
                            prefixIcon: Icons.person_outline_rounded,
                          ),
                        ] else ...[
                          _buildProfileRow(
                            'Full Name',
                            _nameController.text,
                            Icons.person_outline_rounded,
                          ),
                        ],
                        const SizedBox(height: AppSpacing.lg),

                        // Phone number Input / Text
                        if (_isEditing) ...[
                          CustomTextField(
                            controller: _phoneController,
                            label: 'Contact Number',
                            hint: 'Edit mobile',
                            prefixIcon: Icons.phone_android_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                        ] else ...[
                          _buildProfileRow(
                            'Phone Number',
                            _phoneController.text,
                            Icons.phone_android_outlined,
                          ),
                        ],
                        const SizedBox(height: AppSpacing.lg),

                        // Static / Read-only elements
                        _buildProfileRow(
                          'Status Grade',
                          'Ranked Challenger 🎖️',
                          Icons.military_tech_outlined,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xxl),

                  // Terminate session / Logout button
                  ModernButton(
                    text: 'LOGOUT ATHLETE SESSION',
                    onPressed: _logout,
                    gradientColors: [
                      AppColors.error,
                      AppColors.error.withOpacity(0.8),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.04), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: AppColors.textTertiary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
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
