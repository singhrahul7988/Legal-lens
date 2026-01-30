import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mock action
            },
            child: const Text(
              'Mark all as read',
              style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.subtleBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_off_outlined, size: 64, color: AppColors.primaryBlue),
            ),
            const SizedBox(height: 24),
            const Text(
              'No new notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You\'re all caught up! Check back later.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
