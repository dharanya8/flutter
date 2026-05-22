import 'dart:math';
import 'package:flutter/material.dart';
import 'home_screen.dart';

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

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.redAccent : Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _sendOtp() {
    if (_nameController.text.trim().isEmpty) {
      _showMessage("Enter your name", isError: true);
      return;
    }

    if (_phoneController.text.length != 10) {
      _showMessage("Phone number must be 10 digits", isError: true);
      return;
    }

    Random random = Random();

    generatedOtp = (1000 + random.nextInt(9000)).toString();

    setState(() {});

    _showMessage("OTP Sent Successfully");
  }

  Future<void> _login() async {
    if (_otpController.text != generatedOtp) {
      _showMessage("Invalid OTP", isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

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
      backgroundColor: const Color(0xff071C26),
      body: Stack(
        children: [
          /// TOP LEFT CIRCLE
          Positioned(
            top: -120,
            left: -120,
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),

          /// BOTTOM RIGHT CIRCLE
          Positioned(
            bottom: -120,
            right: -120,
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                      color: Colors.white.withOpacity(0.05),
                    ),
                    child: Column(
                      children: [
                        /// ICON
                        Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.purple, Colors.blue],
                            ),
                          ),
                          child: const Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),

                        const SizedBox(height: 25),

                        /// TITLE
                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Login with OTP Verification",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 35),

                        /// NAME FIELD
                        buildTextField(
                          controller: _nameController,
                          hint: "Name",
                          icon: Icons.person,
                        ),

                        const SizedBox(height: 25),

                        /// PHONE FIELD
                        buildTextField(
                          controller: _phoneController,
                          hint: "Phone",
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),

                        const SizedBox(height: 30),

                        /// SEND OTP BUTTON
                        buildButton(text: "Send OTP", onTap: _sendOtp),

                        if (generatedOtp.isNotEmpty) ...[
                          const SizedBox(height: 30),

                          /// OTP SHOW BOX
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.blueAccent),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.lock_open,
                                  color: Colors.lightBlueAccent,
                                ),

                                const SizedBox(width: 10),

                                Text(
                                  "OTP : $generatedOtp",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 35),

                          /// OTP FIELD
                          buildTextField(
                            controller: _otpController,
                            hint: "OTP",
                            icon: Icons.lock,
                            keyboardType: TextInputType.number,
                          ),

                          const SizedBox(height: 35),

                          /// LOGIN BUTTON
                          buildButton(
                            text: _isLoading ? "Loading..." : "Login",
                            onTap: _login,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff0B1B4D),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 25),
          prefixIcon: Icon(icon, color: Colors.lightBlueAccent, size: 25),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget buildButton({required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [Color(0xff4F8CFF), Color(0xff4A7CF0)],
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
