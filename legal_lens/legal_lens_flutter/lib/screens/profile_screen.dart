import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/services/user_image_service.dart';
import '../core/theme/app_theme.dart';

import '../core/models/user_profile_data.dart';
import 'profile/personal_info_screen.dart';
import 'profile/subscription_screen.dart';
import 'profile/app_settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildProfileAvatar(),
          const SizedBox(height: 16),
          Text(
            UserProfileData().name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            UserProfileData().email,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('ACCOUNT'),
          _buildTile(
            icon: Icons.person,
            title: 'Personal Information',
            subtitle: 'Name, Email, Phone',
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (_) => const PersonalInfoScreen())).then((_) => setState(() {}));
            },
          ),
          _buildTile(
            icon: Icons.verified,
            title: 'Subscription Plan',
            subtitle: 'Renew on ${UserProfileData().renewalDate.toString().split(' ')[0]}',
            isPremium: UserProfileData().isPremium,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionScreen())).then((_) => setState(() {}));
            },
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('PREFERENCES'),
          _buildTile(
            icon: Icons.settings,
            title: 'App Settings',
            subtitle: 'Notifications, Appearance',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AppSettingsScreen())).then((_) => setState(() {}));
            },
          ),
          // Security Screen removed
          // _buildTile(
          //   icon: Icons.security,
          //   title: 'Security & Privacy',
          //   subtitle: 'Biometrics, Data sharing',
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (_) => const SecurityScreen())).then((_) => setState(() {}));
          //   },
          // ),
          const SizedBox(height: 40),
          // _buildSignOutButton(), // Disabled for guest mode
          const SizedBox(height: 24),
          const Text(
            'Legal Lens Version 2.4.1 (Build 890)',
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
            onPressed: () {
              if (widget.onBack != null) {
                widget.onBack!();
              } else {
                Navigator.of(context).maybePop();
              }
            },
          ),
          const Text(
            'Profile Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return ValueListenableBuilder<String?>(
      valueListenable: UserImageService().profileImageNotifier,
      builder: (context, imageUrl, _) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                image: imageUrl != null
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(imageUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: Colors.grey.shade200,
              ),
              child: imageUrl == null
                  ? const Icon(Icons.person, size: 60, color: Colors.grey)
                  : null,
            ),
            GestureDetector(
              onTap: _showImageOptions,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Upload Photo'),
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                Navigator.pop(context);
                try {
                  final success = await UserImageService().uploadProfileImage(context);
                  if (!mounted) return;
                  if (success) {
                    messenger.showSnackBar(
                      const SnackBar(content: Text('Profile image updated')),
                    );
                  }
                } catch (e) {
                  if (!mounted) return;
                  messenger.showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Remove Photo', style: TextStyle(color: Colors.red)),
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                Navigator.pop(context);
                try {
                  await UserImageService().removeImage();
                  if (!mounted) return;
                  messenger.showSnackBar(
                    const SnackBar(content: Text('Profile image removed')),
                  );
                } catch (e) {
                  if (!mounted) return;
                  messenger.showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.primaryBlue,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isPremium = false,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primaryBlue, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        if (isPremium) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryYellow.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'PREMIUM',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryYellow,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textGrey),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildSignOutButton() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 24),
  //     child: SizedBox(
  //       width: double.infinity,
  //       height: 56,
  //       child: OutlinedButton.icon(
  //         onPressed: () {},
  //         icon: const Icon(Icons.logout, color: AppColors.error),
  //         label: const Text(
  //           'Sign Out',
  //           style: TextStyle(
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold,
  //             color: AppColors.error,
  //           ),
  //         ),
  //         style: OutlinedButton.styleFrom(
  //           side: const BorderSide(color: AppColors.softError),
  //           backgroundColor: AppColors.softError.withValues(alpha: 0.3),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
