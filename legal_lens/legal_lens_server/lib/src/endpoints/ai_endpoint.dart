import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:legal_lens_server/src/generated/protocol.dart';
import 'package:legal_lens_server/src/services/gemini_service.dart';

class AiEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<AiChatResponse> chat(Session session, AiChatRequest request) async {
    // Guest Mode: Use a fixed UUID for all operations
    final userId = session.authenticated?.authUserId ?? UuidValue.fromString('00000000-0000-0000-0000-000000000000');

    final apiKey = session.serverpod.getPassword('geminiApiKey') ?? 'TEST_KEY';
    
    final geminiService = GeminiService(apiKey);
    
    // 1. Manage Context ID
    String contextId = request.contextId ?? const Uuid().v4();
    final cacheKey = 'chat_history_${userId}_$contextId';

    // 2. Retrieve History
    // We use the local cache for now (single server instance).
    List<Map<String, String>> history = [];
    AiChatHistory chatHistory;
    
    final cached = await session.caches.local.get(cacheKey);
    if (cached is AiChatHistory) {
      chatHistory = cached;
      history = chatHistory.entries.map((e) => {'role': e.role, 'text': e.text}).toList();
    } else {
      chatHistory = AiChatHistory(entries: []);
    }

    // Command Handling
    final inputLower = request.userInput.trim().toLowerCase();
    
    if (inputLower == '/clear') {
       await session.caches.local.invalidateKey(cacheKey);
       return AiChatResponse(
          userInputCopy: request.userInput,
          aiResponse: "Conversation history cleared. I'm ready for a fresh start.",
          suggestedFollowups: ["Analyze a document", "Ask a legal question"],
          contextId: contextId,
       );
    }
    
    if (inputLower == '/context') {
       String contextMsg = "Here are the documents currently in your session context:\n\n";
       if (request.sessionId != null) {
           final sessionDocs = await LegalDoc.db.find(
               session,
               where: (t) => t.sessionId.equals(request.sessionId),
               orderBy: (t) => t.createdAt,
               orderDescending: true,
               limit: 20,
           );
           
           if (sessionDocs.isEmpty) {
               contextMsg += "No documents found in this session.";
           } else {
               for (var d in sessionDocs) {
                   contextMsg += "- **${d.title}** (${d.createdAt.toString().split('.')[0]})\n";
                   if (d.summary != null && d.summary!.isNotEmpty) {
                       contextMsg += "  *${d.summary!.substring(0, d.summary!.length > 100 ? 100 : d.summary!.length)}...*\n";
                   }
               }
           }
       } else {
           contextMsg += "No active session ID found.";
       }
       
       return AiChatResponse(
          userInputCopy: request.userInput,
          aiResponse: contextMsg,
          suggestedFollowups: ["Upload new document", "Clear context"],
          contextId: contextId,
       );
    }

    // 3. Handle Inline Document Upload & Context
    String? docContent;
    String? docName;
    
    if (request.newDocContent != null) {
       // Create temp doc
       var newDoc = LegalDoc(
           userId: userId,
           sessionId: request.sessionId,
           title: request.newDocName ?? 'Uploaded Document',
           content: request.newDocContent,
           type: DocType.general,
           status: DocStatus.processing,
           createdAt: DateTime.now(),
           updatedAt: DateTime.now(),
       );
       
       newDoc = await LegalDoc.db.insertRow(session, newDoc);
       
       // Perform quick analysis
       try {
           final analysisJson = await geminiService.analyzeDocument(newDoc.content ?? "", newDoc.type.name);
           newDoc.analysisJson = analysisJson;
           final scoreMatch = RegExp(r'"score":\s*(\d+)').firstMatch(analysisJson);
           final score = scoreMatch?.group(1) ?? "N/A";
           newDoc.summary = "Analysis complete. Risk Score: $score.";
           newDoc.status = DocStatus.completed;
       } catch (e) {
           newDoc.status = DocStatus.failed;
           newDoc.summary = "Analysis failed: $e";
       }
       
       await LegalDoc.db.updateRow(session, newDoc);
       
       docName = newDoc.title;
       docContent = newDoc.content;
       if (newDoc.summary != null) {
           docContent = "${docContent ?? ""}\n\nSummary: ${newDoc.summary}";
       }
       
       // Add system message about the upload to history so AI knows
       // But 'history' list passed to Gemini shouldn't necessarily include this if we want to prompt it now.
       // Actually, we want the AI to RESPOND to this upload.
    } else if (request.docId != null) {
        final doc = await LegalDoc.db.findById(session, request.docId!);
        if (doc != null) {
            // Unrestricted access: allow context from any document
            docName = doc.title;
            docContent = doc.content ?? "Content not available (URL: ${doc.originalFileUrl})";
            // Append analysis summary if available to give the AI a head start
            if (doc.summary != null) {
                docContent += "\n\nExisting Analysis Summary: ${doc.summary}";
            }
        }
    }

    // 4. Fetch Session Context
    String sessionContextStr = "";
    if (request.sessionId != null) {
        final sessionDocs = await LegalDoc.db.find(
            session,
            where: (t) => t.sessionId.equals(request.sessionId),
            orderBy: (t) => t.createdAt,
            orderDescending: true,
            limit: 50,
        );
        
        if (sessionDocs.isNotEmpty) {
            sessionContextStr = "You have access to the following documents in this session (User may refer to them by number):\n";
            for (var i = 0; i < sessionDocs.length; i++) {
                final d = sessionDocs[i];
                sessionContextStr += "${i+1}. ${d.title} (Uploaded: ${d.createdAt})\n   Summary: ${d.summary ?? 'Pending analysis'}\n";
            }
        }
    }

    // 5. Call Gemini
    final result = await geminiService.chatSession(
        userInput: request.userInput,
        history: history,
        docContent: docContent,
        docName: docName,
        systemContext: sessionContextStr,
    );

    // 6. Update History
    final aiResponseText = result['response'] as String;
    
    chatHistory.entries.add(AiChatHistoryEntry(role: 'user', text: request.userInput));
    chatHistory.entries.add(AiChatHistoryEntry(role: 'model', text: aiResponseText));

    // Limit history to last 20 messages to prevent token overflow
    if (chatHistory.entries.length > 20) {
        chatHistory.entries = chatHistory.entries.sublist(chatHistory.entries.length - 20);
    }

    // 7. Save History (Expire in 1 hour)
    await session.caches.local.put(
        cacheKey, 
        chatHistory, 
        lifetime: const Duration(hours: 1)
    );

    // 8. Return Response
    return AiChatResponse(
        userInputCopy: request.userInput,
        aiResponse: aiResponseText,
        suggestedFollowups: List<String>.from(result['suggestions'] ?? []),
        contextId: contextId,
    );
  }

  Future<DraftGenerationResponse> generateDraft(Session session, DraftGenerationRequest request) async {
    final apiKey = session.serverpod.getPassword('geminiApiKey') ?? 'TEST_KEY';
    final geminiService = GeminiService(apiKey);
    
    final result = await geminiService.generateDraft(
      draftType: request.draftType,
      jurisdiction: request.jurisdiction,
      keyParties: request.keyParties,
      keyTerms: request.keyTerms,
      additionalInstructions: request.additionalInstructions,
    );
    
    return DraftGenerationResponse(
      title: result['title']!,
      content: result['content']!,
    );
  }
}
