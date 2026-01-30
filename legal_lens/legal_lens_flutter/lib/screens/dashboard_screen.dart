import 'dart:async';
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/models/document_model.dart';
import '../core/services/document_repository.dart';
import 'analysis_screen.dart';
import 'files_screen.dart';
import 'ask_ai_screen.dart';
import 'profile_screen.dart';
import 'document_templates_screen.dart';
import 'activity_list_screen.dart';
import 'notifications_screen.dart';
import '../widgets/expandable_fab.dart';
import '../core/services/user_image_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    DocumentRepository().addListener(_onRepositoryUpdate);
    DocumentRepository().fetchDocuments(); // Fetch session docs
    UserImageService().initialize();
  }

  @override
  void dispose() {
    DocumentRepository().removeListener(_onRepositoryUpdate);
    super.dispose();
  }

  void _onRepositoryUpdate() {
    if (mounted) setState(() {});
  }

  void _onItemTapped(int index) {
    if (index == 2) return; // FAB index
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goToHome() {
    _onItemTapped(0);
  }

  @override
  Widget build(BuildContext context) {
    // Re-instantiating pages on every build is okay for this simple app to ensure callbacks are fresh.
    // Or we can just use a switch in the body.
    final List<Widget> pages = [
      const SizedBox(), // Placeholder for Home (index 0) handled in build
      const FilesScreen(),
      const SizedBox(), // Placeholder for Center FAB
      AskAIScreen(onBack: _goToHome),
      ProfileScreen(onBack: _goToHome),
    ];

    final bodyContent = _selectedIndex == 0
        ? _buildDashboardContent(context)
        : pages[_selectedIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: bodyContent,
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: ExpandableFab(
        onAnalyse: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AnalysisScreen()),
          );
        },
        onCreate: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const DocumentTemplatesScreen()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildDashboardContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(),
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 20),
            _buildActionCards(context),
            const SizedBox(height: 32),
            _buildRecentActivityHeader(),
            const SizedBox(height: 16),
            _buildRecentActivityList(),
          ],
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.gavel, size: 16, color: AppColors.primaryBlue),
            ),
            const SizedBox(width: 10),
            const Text(
              'Legal Lens',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
          },
          icon: const Icon(Icons.notifications_none, color: AppColors.textDark),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<String?>(
          valueListenable: UserImageService().profileImageNotifier,
          builder: (context, imageUrl, child) {
            return Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.subtleBlue,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
                image: imageUrl != null
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(imageUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: imageUrl == null
                  ? const Icon(Icons.person, color: AppColors.primaryBlue, size: 28)
                  : null,
            );
          },
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_getGreeting()} Rahul.',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              const TypewriterText(
                phrases: [
                  "I am your Legal lens butler.",
                  "How can I help you today?",
                ],
                textStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors.textGrey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCards(BuildContext context) {
    // Fixed height for better consistency across devices
    // Previous percentage based height was too tall on mobile
    const cardHeight = 190.0;

    return SizedBox(
      height: cardHeight,
      child: Row(
        children: [
          Expanded(
            child: _buildCard(
              context,
              title: 'Analyze a\nDocument',
              subtitle: 'Upload PDF/Image to\nspot red flags',
              icon: Icons.search,
              color: AppColors.primaryBlue,
              textColor: Colors.white,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AnalysisScreen()),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildCard(
              context,
              title: 'Create New\nDraft',
              subtitle: 'Generate fair\nagreements',
              icon: Icons.edit_note,
              color: AppColors.primaryYellow,
              textColor: Colors.white,
              iconColor: Colors.white,
              onTap: () {
                 Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DocumentTemplatesScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color textColor,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor ?? textColor, size: 26),
            ),
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: textColor.withValues(alpha: 0.92),
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivityHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        TextButton(
          onPressed: () {
             Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ActivityListScreen()),
                );
          },
          child: const Text(
            'View All',
            style: TextStyle(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivityList() {
    final recentDocs = DocumentRepository().recentDocuments;

    if (recentDocs.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'No recent activity.\nUpload a document to get started.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textGrey),
        ),
      );
    }

    return Column(
      children: recentDocs.map((doc) => _buildActivityItem(doc)).toList(),
    );
  }

  Widget _buildActivityItem(DocumentModel doc) {
    IconData icon;
    Color iconColor;
    String statusText;
    Color statusColor;
    Color statusBg;

    // Determine Icon
    if (doc.type == DocumentType.rentalAgreement) {
      icon = Icons.home_work;
      iconColor = AppColors.primaryBlue;
    } else if (doc.type == DocumentType.hospitalBill) {
      icon = Icons.local_hospital;
      iconColor = AppColors.error;
    } else {
      icon = Icons.description;
      iconColor = AppColors.secondaryGold;
    }

    // Determine Status
    if (doc.status == DocumentStatus.analyzing) {
      statusText = 'Analyzing...';
      statusColor = AppColors.primaryBlue;
      statusBg = AppColors.primaryBlue.withValues(alpha: 0.1);
    } else if (doc.status == DocumentStatus.analyzed && doc.analysisResult != null) {
      statusText = doc.analysisResult!.riskLabel;
      statusColor = doc.analysisResult!.riskColor;
      statusBg = doc.analysisResult!.riskColor.withValues(alpha: 0.1);
    } else if (doc.status == DocumentStatus.error) {
      statusText = 'Error';
      statusColor = AppColors.error;
      statusBg = AppColors.error.withValues(alpha: 0.1);
    } else {
      statusText = 'Uploaded';
      statusColor = AppColors.textGrey;
      statusBg = AppColors.textGrey.withValues(alpha: 0.1);
    }

    return GestureDetector(
      onTap: () {
        // Always navigate to AnalysisScreen, which handles both Analyzed and Uploaded states
        // and provides a link to Ask AI.
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AnalysisScreen(existingDocId: doc.id)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _timeAgo(doc.uploadDate),
                    style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: statusBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, 'Home', 0),
          _buildNavItem(Icons.folder_open, 'Files', 1),
          const SizedBox(width: 48), // Space for larger FAB
          _buildNavItem(Icons.chat_bubble_outline, 'Ask AI', 3),
          _buildNavItem(Icons.person_outline, 'Profile', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primaryBlue : AppColors.textGrey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.primaryBlue : AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class TypewriterText extends StatefulWidget {
  final List<String> phrases;
  final TextStyle textStyle;
  final Duration typingSpeed;
  final Duration deletingSpeed;
  final Duration pauseDuration;

  const TypewriterText({
    super.key,
    required this.phrases,
    required this.textStyle,
    this.typingSpeed = const Duration(milliseconds: 100),
    this.deletingSpeed = const Duration(milliseconds: 50),
    this.pauseDuration = const Duration(milliseconds: 2000),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  final int _phraseIndex = 0;
  String _currentText = "";
  bool _isTypingComplete = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTyping() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      final currentPhrase = widget.phrases[_phraseIndex];
      
      if (_currentText.length < currentPhrase.length) {
         setState(() {
           _currentText = currentPhrase.substring(0, _currentText.length + 1);
         });
      } else {
        // Typing complete
        timer.cancel();
        if (mounted) {
          setState(() {
            _isTypingComplete = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _isTypingComplete ? _currentText : "$_currentText|",
      style: widget.textStyle,
    );
  }
}
