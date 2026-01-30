import 'dart:convert';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import '../core/theme/app_theme.dart';
import '../core/services/document_repository.dart';
import '../core/models/document_model.dart';
import 'analysis_screen.dart';

class DraftEditorScreen extends StatefulWidget {
  final String title;
  final String? initialContent;

  const DraftEditorScreen({
    super.key,
    required this.title,
    this.initialContent,
  });

  @override
  State<DraftEditorScreen> createState() => _DraftEditorScreenState();
}

class _DraftEditorScreenState extends State<DraftEditorScreen> {
  late QuillController _controller;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool _isExporting = false;
  bool _isAnalyzing = false;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
    if (widget.initialContent != null) {
      _controller.document.insert(0, widget.initialContent!);
    } else {
      _controller.document.insert(0, "Start drafting here...");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _exportToPdf() async {
    if (_isExporting) return;
    
    setState(() {
      _isExporting = true;
    });

    try {
      final doc = pw.Document();
      final plainText = _controller.document.toPlainText();
      
      doc.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) => [
            pw.Header(
              level: 0,
              child: pw.Text(widget.title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20)),
            ),
            pw.Paragraph(text: plainText),
          ],
        ),
      );

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save(),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to export PDF: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isExporting = false;
        });
      }
    }
  }

  Future<void> _analyzeDraft() async {
    if (_isAnalyzing) return;

    setState(() {
      _isAnalyzing = true;
    });

    try {
      final plainText = _controller.document.toPlainText();
      final bytes = utf8.encode(plainText);
      
      final newDoc = DocumentModel(
        id: const Uuid().v4(),
        name: "${widget.title}.txt",
        path: "",
        bytes: Uint8List.fromList(bytes),
        size: bytes.length,
        uploadDate: DateTime.now(),
        status: DocumentStatus.uploaded,
      );
      
      DocumentRepository().addDocument(newDoc);
      
      if (!mounted) return;
      
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AnalysisScreen(
            variant: AnalysisVariant.rental,
            showUpload: false,
            existingDocId: newDoc.id,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to analyze draft: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
      }
    }
  }

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
        title: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Text(
              'Drafting • Saved',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          QuillSimpleToolbar(
            controller: _controller,
            config: const QuillSimpleToolbarConfig(
              showFontFamily: false,
              showFontSize: false,
              showSearchButton: false,
              showInlineCode: false,
              showSubscript: false,
              showSuperscript: false,
              showLink: false,
              showCodeBlock: false,
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: QuillEditor(
              controller: _controller,
              config: const QuillEditorConfig(
                scrollable: true,
                autoFocus: true,
                expands: false,
                padding: EdgeInsets.all(16),
              ),
              focusNode: _focusNode,
              scrollController: _scrollController,
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _isAnalyzing ? null : _analyzeDraft,
                icon: _isAnalyzing 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Icon(Icons.shield_outlined, color: Colors.white, size: 20),
                label: Text(
                  _isAnalyzing ? 'Analyzing...' : 'Analyze for Risks',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _isExporting ? null : _exportToPdf,
                icon: _isExporting
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: AppColors.textDark, strokeWidth: 2))
                  : const Icon(Icons.file_download_outlined, color: AppColors.textDark, size: 20),
                label: Text(
                  _isExporting ? 'Exporting...' : 'Export PDF',
                  style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5F5F7),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
