import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:legal_lens_flutter/core/models/document_model.dart';
import 'package:legal_lens_flutter/core/services/document_repository.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('DocumentRepository Tests', () {
    test('addDocument adds a document to the list', () {
      final repo = DocumentRepository();
      // Reset for test
      // Note: Since DocumentRepository is a singleton in implementation, we rely on its state.
      // Ideally we would reset it, but for now we just check increment.
      final initialCount = repo.documents.length;
      
      final doc = DocumentModel(
        id: const Uuid().v4(),
        name: 'Test Doc',
        path: '/test/path',
        size: 1024,
        uploadDate: DateTime.now(),
      );

      repo.addDocument(doc);

      expect(repo.documents.length, initialCount + 1);
      expect(repo.getDocument(doc.id), isNotNull);
    });

    test('setAnalysisResult updates document status and stores result', () {
      final repo = DocumentRepository();
      final docId = const Uuid().v4();
      final doc = DocumentModel(
        id: docId,
        name: 'Analysis Test Doc',
        path: '/test/path',
        size: 1024,
        uploadDate: DateTime.now(),
      );
      repo.addDocument(doc);

      final result = AnalysisResultModel(
        title: 'Analysis Result',
        score: 85,
        riskLabel: 'Low Risk',
        riskDescription: 'Safe document',
        riskColor: Colors.green,
        summaryPoints: ['Point 1'],
        redFlags: [],
      );

      repo.setAnalysisResult(docId, result);

      final updatedDoc = repo.getDocument(docId);
      expect(updatedDoc?.status, DocumentStatus.analyzed);
      expect(updatedDoc?.analysisResult, isNotNull);
      expect(updatedDoc?.analysisResult?.score, 85);
    });
  });
}
