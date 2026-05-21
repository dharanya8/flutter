import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../widgets/custom_button.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String phone;
  // final String email;
  // final String password;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.phone,
    // required this.email,
    // required this.password,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  late TextEditingController _nameController;
  // late TextEditingController _emailController;
  late TextEditingController _phoneController;
  // late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.name);
    // _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
    // _passwordController = TextEditingController(text: widget.password);
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Logout', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    // _emailController.dispose();
    _phoneController.dispose();
    // _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            child: Text(_isEditing ? 'Save' : 'Edit'),
          ),
        ],
      ),
      body: Container(
        decoration: AppStyles.gradientBackground,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: const Icon(Icons.person, size: 60),
              ),

              const SizedBox(height: 20),

              _buildField("Name", _nameController),
              // _buildField("Email", _emailController),
              _buildField("Phone", _phoneController),

              // _buildField("Password", _passwordController),
              const SizedBox(height: 30),

              CustomButton(text: 'Logout', onPressed: _logout),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        enabled: _isEditing,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
