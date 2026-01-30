import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/user_profile_data.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _nameController = TextEditingController(text: UserProfileData().name);
  final _emailController = TextEditingController(text: UserProfileData().email);
  final _phoneController = TextEditingController(text: UserProfileData().phone);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _save() {
    setState(() {
      UserProfileData().updateProfile(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile Updated')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Personal Information', style: TextStyle(color: AppColors.textDark)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildTextField("Full Name", _nameController),
            const SizedBox(height: 16),
            _buildTextField("Email", _emailController),
            const SizedBox(height: 16),
            _buildTextField("Phone Number", _phoneController),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
