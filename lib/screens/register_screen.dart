import 'package:flutter/material.dart';
import '../screens/success_screen.dart';
import '../models/sport_model.dart';

class RegisterScreen extends StatefulWidget {
  final SportModel sport;

  const RegisterScreen({super.key, required this.sport});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _teamNameController = TextEditingController();

  bool _isLoading = false;

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),

        backgroundColor: isError ? Colors.red : Colors.green,

        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _submitRegistration() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        _showSnackbar('Registration Successful!');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SuccessScreen(sport: widget.sport)),
        );
      }
    } else {
      _showSnackbar('Please fill all fields correctly', isError: true);
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _teamNameController.dispose();
    super.dispose();
  }

  Widget customTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,

        hintStyle: const TextStyle(color: Colors.grey),

        labelStyle: const TextStyle(color: Colors.white),

        prefixIcon: Icon(icon, color: Colors.orange),

        filled: true,
        fillColor: const Color(0xff1E293B),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),

          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),

          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
      ),

      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,

        title: Text(
          "${widget.sport.name} Registration",

          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),

          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0F172A), Color(0xff1E293B), Color(0xff334155)],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // HEADER CARD
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),

                    gradient: LinearGradient(
                      colors: [
                        widget.sport.color,
                        widget.sport.color.withOpacity(0.7),
                      ],
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: widget.sport.color.withOpacity(0.4),

                        blurRadius: 15,

                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 38,

                        backgroundColor: Colors.white,

                        child: Icon(
                          widget.sport.icon,
                          size: 45,
                          color: widget.sport.color,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        widget.sport.name,

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Tournament Registration Form",

                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Personal Details",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // FULL NAME
                customTextField(
                  controller: _fullNameController,

                  label: "Full Name",

                  hint: "Enter your name",

                  icon: Icons.person,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter full name";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // PHONE
                customTextField(
                  controller: _phoneController,

                  label: "Phone Number",

                  hint: "Enter phone number",

                  icon: Icons.phone,

                  keyboardType: TextInputType.phone,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter phone number";
                    }

                    if (value.length < 10) {
                      return "Invalid phone number";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // EMAIL
                customTextField(
                  controller: _emailController,

                  label: "Email",

                  hint: "Enter email",

                  icon: Icons.email,

                  keyboardType: TextInputType.emailAddress,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter email";
                    }

                    if (!value.contains("@")) {
                      return "Invalid email";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // TEAM NAME
                customTextField(
                  controller: _teamNameController,

                  label: "Team Name",

                  hint: "Enter team name",

                  icon: Icons.group,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter team name";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 35),

                // REGISTER BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 60,

                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitRegistration,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.sport.color,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),

                      elevation: 10,
                    ),

                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "REGISTER NOW",

                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,

                              letterSpacing: 1,

                              color: Colors.white,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
