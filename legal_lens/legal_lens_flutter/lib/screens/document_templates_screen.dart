import 'package:flutter/material.dart';
import '../core/enums/draft_type.dart';
import 'create_draft_screen.dart';

class DocumentTemplatesScreen extends StatefulWidget {
  const DocumentTemplatesScreen({super.key});

  @override
  State<DocumentTemplatesScreen> createState() => _DocumentTemplatesScreenState();
}

class _DocumentTemplatesScreenState extends State<DocumentTemplatesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create New Document',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 24),
            _buildSectionHeader('HOUSING & REAL ESTATE'),
            _buildTemplateCard(
              icon: Icons.home_work,
              title: 'Rental/Lease Agreement',
              subtitle: 'Standard residential property lease',
              color: const Color(0xFFEEF2FF),
              iconColor: const Color(0xFF4A4E9E),
              type: DraftType.rentalAgreement,
            ),
            _buildTemplateCard(
              icon: Icons.door_front_door,
              title: 'Notice to Vacate',
              subtitle: 'Formal notice to end tenancy',
              color: const Color(0xFFFFF4E5),
              iconColor: const Color(0xFFFF6B00),
              type: DraftType.noticeToVacate,
            ),
            _buildTemplateCard(
              icon: Icons.trending_up,
              title: 'Rent Increase Notice',
              subtitle: 'Legal notice for adjusting rent',
              color: const Color(0xFFE8FDF0),
              iconColor: const Color(0xFF00C853),
              type: DraftType.rentIncreaseNotice,
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('CONSUMER RIGHTS'),
            _buildTemplateCard(
              icon: Icons.local_hospital,
              title: 'Medical Bill Complaint',
              subtitle: 'Dispute incorrect hospital charges',
              color: const Color(0xFFFFEBEE),
              iconColor: const Color(0xFFD32F2F),
              type: DraftType.medicalBillComplaint,
            ),
            _buildTemplateCard(
              icon: Icons.shopping_bag,
              title: 'Consumer Complaint',
              subtitle: 'Reporting defective goods or services',
              color: const Color(0xFFE3F2FD),
              iconColor: const Color(0xFF1976D2),
              type: DraftType.consumerComplaint,
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('EMPLOYMENT'),
            _buildTemplateCard(
              icon: Icons.logout,
              title: 'Resignation Letter',
              subtitle: 'Professional notice of departure',
              color: const Color(0xFFF3E5F5),
              iconColor: const Color(0xFF7B1FA2),
              type: DraftType.resignationLetter,
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('GENERAL'),
             _buildTemplateCard(
              icon: Icons.edit_document,
              title: 'Custom Document',
              subtitle: 'Create a document from scratch',
              color: const Color(0xFFF5F5F5),
              iconColor: Colors.black54,
              type: DraftType.custom,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search templates...',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF5F5F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTemplateCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color iconColor,
    required DraftType type,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateDraftScreen(draftType: type),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color,
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
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
