import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../core/theme/app_theme.dart';
import '../widgets/score_gauge.dart';
import '../core/services/document_repository.dart';
import '../core/models/document_model.dart';
import 'ask_ai_screen.dart';

enum AnalysisVariant {
  hospital,
  rental,
}

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({
    super.key,
    this.variant = AnalysisVariant.hospital,
    this.showUpload = true,
    this.existingDocId,
  });

  final AnalysisVariant variant;
  final bool showUpload;
  final String? existingDocId;

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  bool _isLoading = false;
  String? _currentDocId;
  bool _analysisComplete = false;

  // Helper to get current doc from repo
  DocumentModel? get _currentDoc => 
      _currentDocId != null ? DocumentRepository().getDocument(_currentDocId!) : null;

  @override
  void initState() {
    super.initState();
    if (widget.existingDocId != null) {
      _currentDocId = widget.existingDocId;
      final doc = DocumentRepository().getDocument(widget.existingDocId!);
      if (doc != null && doc.status == DocumentStatus.analyzed) {
        _analysisComplete = true;
      }
    }
  }

  Future<void> _handleUpload() async {
    setState(() => _isLoading = true);

    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'docx', 'txt'],
        withData: true, // Required for Web to get bytes
      );

      if (result == null) {
        setState(() => _isLoading = false);
        return;
      }

      // Simulate Upload Delay
      await Future.delayed(const Duration(seconds: 1));

      final file = result.files.single;
      final newDoc = DocumentModel(
        id: const Uuid().v4(),
        name: file.name,
        path: file.path ?? '', // Path might be null on web
        bytes: file.bytes,
        size: file.size,
        uploadDate: DateTime.now(),
        status: DocumentStatus.uploaded,
      );

      DocumentRepository().addDocument(newDoc);

      if (!mounted) return;

      setState(() {
        _currentDocId = newDoc.id;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _performAnalysis() async {
    if (_currentDocId == null) return;

    // Auth check removed for unrestricted access
    
    setState(() => _isLoading = true);

    try {
      // Use Repository to perform analysis (Real API Call)
      await DocumentRepository().performAnalysis(_currentDocId!);
      
      // Note: performAnalysis internally updates the repository state

      if (!mounted) return;

      setState(() {
        _analysisComplete = true;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Analysis Failed: $e')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _analysisComplete ? (_currentDoc?.analysisResult?.title ?? 'Analysis Result') : 'Analyze Document',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          if (_analysisComplete)
            IconButton(
              icon: const Icon(Icons.ios_share_outlined),
              onPressed: () {},
            ),
        ],
      ),
      body: _analysisComplete ? _buildResultView() : _buildUploadFlow(),
      bottomNavigationBar: _analysisComplete ? _buildBottomAction() : null,
    );
  }

  Widget _buildUploadFlow() {
    if (_currentDocId != null && !_isLoading) {
      return _buildUploadSuccessView();
    }
    return _buildUploadView();
  }

  Widget _buildUploadSuccessView() {
    final doc = _currentDoc!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline,
                size: 64,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'File Uploaded Successfully',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.description, color: AppColors.primaryBlue, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${(doc.size / 1024).toStringAsFixed(1)} KB • ${doc.uploadDate.toString().split('.')[0]}',
                          style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _performAnalysis,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.analytics_outlined, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Analyze Document',
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  _currentDocId = null;
                });
              },
              child: const Text('Upload Different File', style: TextStyle(color: AppColors.textGrey)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction() {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: SizedBox(
        height: 54,
        child: ElevatedButton.icon(
          onPressed: () {
            // Navigate to Ask AI with context
            if (_currentDocId != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AskAIScreen(initialDocId: _currentDocId),
                ),
              );
            }
          },
          icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          label: const Text(
            'Ask AI Chat',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cloud_upload_outlined,
                size: 64,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Upload your document',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'PDF, JPG, PNG, DOCX supported',
              style: TextStyle(color: AppColors.textGrey),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleUpload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          ),
                          SizedBox(width: 12),
                          Text('Processing...', style: TextStyle(color: Colors.white)),
                        ],
                      )
                    : const Text(
                        'Select Document',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView() {
    final result = _currentDoc?.analysisResult;
    if (result == null) return const SizedBox.shrink();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
              decoration: BoxDecoration(
                color: result.riskColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ScoreGauge(
                score: result.score,
                label: result.riskLabel,
                description: result.riskDescription,
                accentColor: result.riskColor,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: const [
              Icon(Icons.auto_awesome, color: AppColors.primaryBlue),
              SizedBox(width: 8),
              Text(
                'AI Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: result.summaryPoints
                  .map(
                    (point) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle, color: AppColors.primaryBlue, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  point,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.textDark,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (point != result.summaryPoints.last)
                          const Divider(height: 1, color: AppColors.border),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Red Flags',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${result.redFlags.length} Issues',
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...result.redFlags.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildRedFlagCard(item),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildRedFlagCard(RedFlagModel item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: item.severity == 'High',
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: item.severity == 'High' ? Colors.red.shade50 : Colors.orange.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.severity == 'High' ? Icons.warning_rounded : Icons.info_outline,
              color: item.severity == 'High' ? AppColors.error : AppColors.warning,
              size: 20,
            ),
          ),
          title: Text(
            item.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Severity: ${item.severity}',
            style: TextStyle(
              color: item.severity == 'High' ? AppColors.error : AppColors.warning,
              fontSize: 12,
            ),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            Text(
              item.description,
              style: const TextStyle(color: AppColors.textGrey, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

// Legacy classes removed as we now use models