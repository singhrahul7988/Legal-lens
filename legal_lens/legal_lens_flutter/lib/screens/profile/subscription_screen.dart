import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/user_profile_data.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Subscription Plan', style: TextStyle(color: AppColors.textDark)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryBlue, Color(0xFF4A4E9E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('PREMIUM PLAN', style: TextStyle(color: Colors.white70, letterSpacing: 1.2)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.primaryYellow, borderRadius: BorderRadius.circular(8)),
                        child: const Text('ACTIVE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('₹499 / Month', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Renews on ${UserProfileData().renewalDate.toString().split(' ')[0]}', style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildFeatureRow('Unlimited Document Analysis'),
            _buildFeatureRow('Advanced Templates'),
            _buildFeatureRow('Priority Support'),
            _buildFeatureRow('Cloud Backup'),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.success),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 16, color: AppColors.textDark)),
        ],
      ),
    );
  }
}
