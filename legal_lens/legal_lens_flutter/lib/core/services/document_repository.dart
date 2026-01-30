import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:legal_lens_client/legal_lens_client.dart' as api;
import '../../main.dart'; // Access global 'client' variable
import '../models/document_model.dart';
import 'session_manager.dart';
import '../utils/document_processor.dart';

class DocumentRepository extends ChangeNotifier {
  // Singleton instance
  static final DocumentRepository _instance = DocumentRepository._internal();
  factory DocumentRepository() => _instance;
  DocumentRepository._internal();

  // ... (keeping existing properties and CRUD methods)

  // In-memory storage
  final List<DocumentModel> _documents = [];

  // Getters
  List<DocumentModel> get documents => List.unmodifiable(_documents);
  
  List<DocumentModel> get recentDocuments {
    final sorted = List<DocumentModel>.from(_documents)
      ..sort((a, b) => b.uploadDate.compareTo(a.uploadDate));
    return sorted.take(5).toList();
  }

  // CRUD Operations
  void addDocument(DocumentModel doc) {
    _documents.add(doc);
    notifyListeners();
  }

  void deleteDocument(String id) {
    _documents.removeWhere((doc) => doc.id == id);
    notifyListeners();
  }

  DocumentModel? getDocument(String id) {
    try {
      return _documents.firstWhere((doc) => doc.id == id);
    } catch (e) {
      return null;
    }
  }

  void updateStatus(String id, DocumentStatus newStatus) {
    final index = _documents.indexWhere((doc) => doc.id == id);
    if (index != -1) {
      _documents[index].status = newStatus;
      notifyListeners();
    }
  }

  void setAnalysisResult(String id, AnalysisResultModel result, {int? serverId}) {
    final index = _documents.indexWhere((doc) => doc.id == id);
    if (index != -1) {
      _documents[index] = DocumentModel(
        id: _documents[index].id,
        serverId: serverId ?? _documents[index].serverId,
        name: _documents[index].name,
        path: _documents[index].path,
        bytes: _documents[index].bytes,
        size: _documents[index].size,
        uploadDate: _documents[index].uploadDate,
        status: DocumentStatus.analyzed, // Auto update status
        type: _determineTypeFromTitle(result.title),
        analysisResult: result,
        chatHistory: _documents[index].chatHistory,
      );
      notifyListeners();
    }
  }
  
  void addChatMessage(String docId, ChatMessageModel message) {
    final index = _documents.indexWhere((doc) => doc.id == docId);
    if (index != -1) {
      final updatedHistory = List<ChatMessageModel>.from(_documents[index].chatHistory)..add(message);
      _documents[index].chatHistory = updatedHistory;
      notifyListeners();
    }
  }

  DocumentType _determineTypeFromTitle(String title) {
    if (title.toLowerCase().contains('rent') || title.toLowerCase().contains('lease')) {
      return DocumentType.rentalAgreement;
    } else if (title.toLowerCase().contains('bill') || title.toLowerCase().contains('hospital')) {
      return DocumentType.hospitalBill;
    }
    return DocumentType.other;
  }

  // Real Analysis using Gemini via Serverpod
  Future<AnalysisResultModel> performAnalysis(String docId) async {
    // Auth check removed for unrestricted access
    
    final doc = getDocument(docId);
    if (doc == null) throw Exception('Document not found');
    
    updateStatus(docId, DocumentStatus.analyzing);

    try {
      // 1. Read content using DocumentProcessor
      String content = await DocumentProcessor.extractContent(
        name: doc.name,
        bytes: doc.bytes,
        path: doc.path,
      );

      // 2. Create document on server
      // Map local model to server protocol
      var legalDoc = api.LegalDoc(
        userId: api.UuidValue.fromString('00000000-0000-0000-0000-000000000000'), // Dummy User ID
        sessionId: SessionManager().sessionId, // Add Session ID
        title: doc.name,
        content: content,
        summary: "",
        status: api.DocStatus.pending,
        type: api.DocType.general, 
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      // Use global 'client' from main.dart
      final createdDoc = await client.document.createDocument(legalDoc);
      
      if (createdDoc.id == null) throw Exception("Failed to create document on server");

      // 3. Trigger Analysis
      final analyzedDoc = await client.document.analyzeDocument(createdDoc.id!);

      if (analyzedDoc.analysisJson == null) {
          // Fallback if JSON missing but summary exists
          if (analyzedDoc.summary != null) {
             final fallbackResult = AnalysisResultModel(
                title: analyzedDoc.title,
                score: 50,
                riskLabel: "Unknown",
                riskDescription: analyzedDoc.summary!,
                riskColor: Colors.grey,
              );
             setAnalysisResult(docId, fallbackResult, serverId: createdDoc.id);
             return fallbackResult;
          }
          throw Exception("Analysis failed or returned empty");
      }

      // 4. Parse Result
      final result = AnalysisResultModel.fromJson(jsonDecode(analyzedDoc.analysisJson!));
      
      setAnalysisResult(docId, result, serverId: createdDoc.id);
      return result;
      
    } catch (e) {
      updateStatus(docId, DocumentStatus.error);
      rethrow;
    }
  }

  /// Fetches documents from the server for the current session
  Future<void> fetchDocuments() async {
    try {
      final sessionId = SessionManager().sessionId;
      final serverDocs = await client.document.getDocumentsBySession(sessionId);
      
      _documents.clear();
      
      for (var doc in serverDocs) {
        AnalysisResultModel? analysisResult;
        if (doc.analysisJson != null) {
          try {
            analysisResult = AnalysisResultModel.fromJson(jsonDecode(doc.analysisJson!));
          } catch (e) {
            debugPrint("Error parsing analysis JSON for doc ${doc.id}: $e");
          }
        }

        _documents.add(DocumentModel(
          id: doc.id.toString(), // Use server ID as local ID for fetched docs
          serverId: doc.id,
          name: doc.title,
          path: '', // No local path for fetched docs
          size: doc.content?.length ?? 0,
          uploadDate: doc.createdAt,
          status: doc.status == api.DocStatus.completed ? DocumentStatus.analyzed : DocumentStatus.analyzing,
          type: _mapServerTypeToLocal(doc.type),
          analysisResult: analysisResult,
        ));
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching documents: $e");
    }
  }

  DocumentType _mapServerTypeToLocal(api.DocType type) {
    switch (type) {
      case api.DocType.rental_agreement:
        return DocumentType.rentalAgreement;
      case api.DocType.medical_bill:
        return DocumentType.hospitalBill;
      case api.DocType.employment_offer:
        return DocumentType.other; // Map others as needed
      default:
        return DocumentType.other;
    }
  }
}