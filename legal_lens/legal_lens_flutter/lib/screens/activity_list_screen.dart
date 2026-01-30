import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/services/document_repository.dart';
import '../core/models/document_model.dart';
import 'analysis_screen.dart';

class ActivityListScreen extends StatelessWidget {
  const ActivityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use all documents for the full activity list, sorted by date descending
    final docs = List<DocumentModel>.from(DocumentRepository().documents);
    docs.sort((a, b) => b.uploadDate.compareTo(a.uploadDate));

    return Scaffold(
      appBar: AppBar(title: const Text('Recent Activity')),
      body: docs.isEmpty 
        ? Center(
            child: Text(
              'No activity yet',
              style: TextStyle(color: AppColors.textGrey.withValues(alpha: 0.7)),
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: docs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final doc = docs[index];
              return _buildRealActivityItem(context, doc);
            },
          ),
    );
  }

  Widget _buildRealActivityItem(BuildContext context, DocumentModel doc) {
    IconData icon;
    Color iconColor;
    Color iconBg;
    String statusText;
    Color statusColor;
    Color statusBg;

    // Determine Icon
    if (doc.type == DocumentType.rentalAgreement) {
      icon = Icons.home_work;
      iconColor = AppColors.primaryBlue;
      iconBg = AppColors.primaryBlue.withValues(alpha: 0.1);
    } else if (doc.type == DocumentType.hospitalBill) {
      icon = Icons.local_hospital;
      iconColor = AppColors.error;
      iconBg = AppColors.error.withValues(alpha: 0.1);
    } else {
      icon = Icons.description;
      iconColor = AppColors.secondaryGold;
      iconBg = AppColors.secondaryGold.withValues(alpha: 0.1);
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
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AnalysisScreen(existingDocId: doc.id),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBg,
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
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(doc.uploadDate),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                statusText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
