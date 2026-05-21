import 'dart:math';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../widgets/custom_textfield.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

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

  // Snackbar
  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // OTP Generate
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

  // Login
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

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Background circles
            Positioned(
              top: -60,
              left: -60,
              child: _circle(140, Colors.white24),
            ),
            Positioned(
              bottom: -80,
              right: -50,
              child: _circle(180, Colors.white10),
            ),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),

                        // Icon
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.purple, Colors.blue],
                            ),
                          ),
                          child: const Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "Login with OTP Verification",
                          style: TextStyle(color: Colors.white70),
                        ),

                        const SizedBox(height: 25),

                        // Name
                        CustomTextField(
                          controller: _nameController,
                          label: 'Name',
                          hint: 'Enter your name',
                          prefixIcon: Icons.person,
                          validator: (v) => v!.isEmpty ? 'Enter name' : null,
                        ),

                        const SizedBox(height: 15),

                        // Phone
                        CustomTextField(
                          controller: _phoneController,
                          label: 'Phone',
                          hint: 'Enter phone number',
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

                        const SizedBox(height: 15),

                        // Send OTP
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _sendOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text("Send OTP"),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // OTP Display
                        if (generatedOtp.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Text(
                              "OTP: $generatedOtp",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        const SizedBox(height: 15),

                        // OTP input
                        CustomTextField(
                          controller: _otpController,
                          label: 'OTP',
                          hint: 'Enter OTP',
                          prefixIcon: Icons.lock,
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

                        const SizedBox(height: 25),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : const Text("Login"),
                          ),
                        ),
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
