import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/user_profile_data.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('App Settings', style: TextStyle(color: AppColors.textDark)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSwitchTile(
            'Push Notifications', 
            'Receive alerts for document updates', 
            UserProfileData().notificationsEnabled, 
            (val) => setState(() => UserProfileData().notificationsEnabled = val)
          ),
          _buildSwitchTile(
            'Dark Mode', 
            'Switch to dark theme', 
            UserProfileData().darkMode, 
            (val) => setState(() => UserProfileData().darkMode = val)
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textGrey)),
        value: value,
        onChanged: onChanged,
        activeTrackColor: AppColors.primaryBlue,
      ),
    );
  }
}
