import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class ReviewDraftScreen extends StatelessWidget {
  const ReviewDraftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Draft'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDocumentCard(),
              const SizedBox(height: 16),
              _buildButlerTip(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildDocumentCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.subtleBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'CONFIDENTIAL',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Employment\nAgreement',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Version 2.4 - Last edited just now',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.subtleBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.notifications_off_outlined,
                  size: 18,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
          const Divider(height: 32, color: AppColors.border),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: AppColors.textGrey,
                fontSize: 14,
                height: 1.6,
              ),
              children: [
                const TextSpan(text: 'This Employment Agreement (the "Agreement") is made and entered into as of '),
                TextSpan(
                  text: 'October 24, 2023',
                  style: TextStyle(
                    color: AppColors.textDark,
                    backgroundColor: AppColors.primaryYellow.withValues(alpha: 0.2),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ', by and between '),
                TextSpan(
                  text: 'TechVision Inc.',
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ' ("Employer") and '),
                TextSpan(
                  text: 'Sarah J. Mitchell',
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ' ("Employee").'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '1. Position and Duties',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: AppColors.textGrey,
                fontSize: 14,
                height: 1.6,
              ),
              children: [
                const TextSpan(text: 'Employer hereby employs Employee as '),
                TextSpan(
                  text: 'Senior Legal Consultant',
                  style: TextStyle(
                    color: AppColors.textDark,
                    backgroundColor: AppColors.primaryYellow.withValues(alpha: 0.25),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(
                  text:
                      ', and Employee hereby accepts such employment. Employee shall perform such duties and responsibilities as are customarily associated with such position.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButlerTip() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: const BorderSide(color: AppColors.primaryBlue, width: 3),
          right: BorderSide(color: AppColors.primaryBlue.withValues(alpha: 0.15)),
          top: BorderSide(color: AppColors.primaryBlue.withValues(alpha: 0.15)),
          bottom:
              BorderSide(color: AppColors.primaryBlue.withValues(alpha: 0.15)),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.subtleBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.smart_toy_outlined, color: AppColors.primaryBlue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BUTLER TIP',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 6),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 13,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(
                            text:
                                'Standard notice in this jurisdiction is usually ',
                          ),
                          const TextSpan(
                            text: '60 days',
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: '. Update automatically?'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 36,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: -6,
            right: -6,
            child: IconButton(
              icon: const Icon(Icons.close, size: 16, color: AppColors.textGrey),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh, color: AppColors.primaryBlue, size: 18),
                label: const Text(
                  'Re-Analyze',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.upload_file, color: Colors.white, size: 18),
                label: const Text(
                  'Export & Share PDF',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

