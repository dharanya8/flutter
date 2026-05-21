import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/home_screen.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/modern_button.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../constants/app_spacing.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _isLoading = false;
  String generatedOtp = '';

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(AppSpacing.lg),
      ),
    );
  }

  void _sendOtp() {
    if (_phoneController.text.isEmpty) {
      _showSnackbar('Enter phone number', isError: true);
      return;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(_phoneController.text)) {
      _showSnackbar('Only digits allowed', isError: true);
      return;
    }

    if (_phoneController.text.length != 10) {
      _showSnackbar('Phone must be 10 digits', isError: true);
      return;
    }

    Random random = Random();
    generatedOtp = (1000 + random.nextInt(9000)).toString();

    setState(() {});
    _showSnackbar('OTP Sent Successfully');
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    if (_otpController.text != generatedOtp) {
      _showSnackbar('Invalid OTP', isError: true);
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isLoading = false);
    _showSnackbar('Login Successful');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          name: _nameController.text,
          phone: _phoneController.text,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppStyles.gradientBackground,
        child: Stack(
          children: [
            // Gradient background spheres
            Positioned(
              top: -80,
              right: -80,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.2),
                      AppColors.secondary.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -120,
              left: -60,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accent2.withOpacity(0.1),
                      AppColors.primary.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
            // Main content
            SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.xl,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: AppSpacing.xxl),
                        // Header
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: AppColors.premiumGradient,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        Text(
                          'Welcome Back',
                          style: AppStyles.heading2,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Login with OTP Verification',
                          style: AppStyles.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.xxxl),
                        // Glass morphism card
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          decoration: BoxDecoration(
                            color: AppColors.surface.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Name
                              CustomTextField(
                                controller: _nameController,
                                label: 'Full Name',
                                hint: 'Enter your full name',
                                prefixIcon: Icons.person,
                                validator: (v) =>
                                    v!.isEmpty ? 'Enter name' : null,
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              // Phone
                              CustomTextField(
                                controller: _phoneController,
                                label: 'Phone Number',
                                hint: 'Enter your phone number',
                                prefixIcon: Icons.phone,
                                keyboardType: TextInputType.phone,
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Enter phone';
                                  }
                                  if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
                                    return 'Only digits allowed';
                                  }
                                  if (v.length != 10) {
                                    return 'Must be 10 digits';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              // Send OTP button
                              ModernButton(
                                text: 'Send OTP',
                                onPressed: _sendOtp,
                              ),
                              // OTP Display
                              if (generatedOtp.isNotEmpty) ...[
                                const SizedBox(height: AppSpacing.lg),
                                Container(
                                  padding: const EdgeInsets.all(AppSpacing.lg),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(
                                      AppSpacing.radiusLg,
                                    ),
                                    border: Border.all(
                                      color: AppColors.primary.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: AppColors.primary,
                                        size: AppSpacing.iconMedium,
                                      ),
                                      const SizedBox(width: AppSpacing.md),
                                      Text(
                                        'OTP: $generatedOtp',
                                        style: GoogleFonts.poppins(
                                          color: AppColors.primary,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              if (generatedOtp.isNotEmpty) ...[
                                const SizedBox(height: AppSpacing.lg),
                                // OTP input
                                CustomTextField(
                                  controller: _otpController,
                                  label: 'Enter OTP',
                                  hint: 'Enter 4-digit OTP',
                                  prefixIcon: Icons.verified_user,
                                  keyboardType: TextInputType.number,
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return 'Enter OTP';
                                    }
                                    if (v.length != 4) {
                                      return 'OTP must be 4 digits';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: AppSpacing.xl),
                                // Login button
                                ModernButton(
                                  text: 'Login',
                                  onPressed: _login,
                                  isLoading: _isLoading,
                                  gradientColors:
                                      AppColors.purpleGradient,
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxxl),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
