import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/gemini_service.dart';

class DocumentEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  /// Uploads a document record to the database.
  /// Note: The actual file content should be stored in cloud storage,
  /// and the URL passed here.
  Future<LegalDoc> createDocument(Session session, LegalDoc doc) async {
    // Guest Mode: Use a fixed UUID for all operations
    final userId = UuidValue.fromString('00000000-0000-0000-0000-000000000000');

    doc.createdAt = DateTime.now();
    doc.updatedAt = DateTime.now();
    doc.userId = userId;
    
    // Insert returns the object with the ID populated
    doc = await LegalDoc.db.insertRow(session, doc);
    return doc;
  }

  /// Trigger analysis for a document using Gemini.
  Future<LegalDoc> analyzeDocument(Session session, int docId) async {
    // Guest Mode: Use a fixed UUID for all operations
    // final userId = session.authenticated?.authUserId ?? UuidValue.fromString('00000000-0000-0000-0000-000000000000');

    var doc = await LegalDoc.db.findById(session, docId);
    if (doc == null) {
      throw Exception('Document not found');
    }

    // Unrestricted access: Auth check removed
    // if (doc.userId != userId) {
    //   throw Exception('Unauthorized access to document');
    // }

    doc.status = DocStatus.processing;
    await LegalDoc.db.updateRow(session, doc);

    try {
      final apiKey = session.serverpod.getPassword('geminiApiKey');
      if (apiKey == null || apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
        throw Exception('Gemini API Key not configured in passwords.yaml');
      }

      final geminiService = GeminiService(apiKey);
      
      // Use doc.content if available. In a real app, we might fetch from S3/URL.
      String contentToAnalyze = doc.content ?? "No content available.";
      if (contentToAnalyze.length < 10 && doc.originalFileUrl != null) {
          // Placeholder for file fetching logic
          contentToAnalyze = "Document content from URL: ${doc.originalFileUrl}";
      }

      final analysisJson = await geminiService.analyzeDocument(contentToAnalyze, doc.type.name);

      doc.analysisJson = analysisJson;
      
      // Extract a simple summary for the summary field (fallback)
      final scoreMatch = RegExp(r'"score":\s*(\d+)').firstMatch(analysisJson);
      final score = scoreMatch?.group(1) ?? "N/A";
      
      doc.summary = "Analysis complete. Risk Score: $score. See full analysis for details.";
      doc.status = DocStatus.completed;
      
    } catch (e, stackTrace) {
      doc.status = DocStatus.failed;
      doc.summary = "Analysis failed: $e";
      session.log("Analysis failed for doc $docId", level: LogLevel.error, exception: e, stackTrace: stackTrace);
    }

    doc.updatedAt = DateTime.now();
    await LegalDoc.db.updateRow(session, doc);
    return doc;
  }

  /// Get all documents for a specific session
  Future<List<LegalDoc>> getDocumentsBySession(Session session, String sessionId) async {
    return await LegalDoc.db.find(
      session,
      where: (t) => t.sessionId.equals(sessionId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }
}
