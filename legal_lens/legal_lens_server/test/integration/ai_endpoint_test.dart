import 'package:test/test.dart';
import 'package:serverpod/serverpod.dart';
import 'package:legal_lens_server/src/generated/protocol.dart';
import 'package:legal_lens_server/src/services/gemini_service.dart';
import 'test_tools/serverpod_test_tools.dart';

class MockGeminiService extends GeminiService {
  MockGeminiService() : super('mock_key');

  // We can capture the last called arguments to verify them
  String? lastSystemContext;
  String? lastDocContent;
  String? lastDocName;

  @override
  Future<Map<String, dynamic>> chatSession({
    required String userInput,
    required List<Map<String, String>> history,
    String? docContent,
    String? docName,
    String? systemContext,
  }) async {
    lastSystemContext = systemContext;
    lastDocContent = docContent;
    lastDocName = docName;
    
    return {
      "response": "Mock response for $userInput",
      "suggestions": ["Mock suggestion"],
    };
  }
  
  @override
  Future<String> analyzeDocument(String textContent, String docType) async {
    return '{"score": 85, "riskLabel": "Safe", "summaryPoints": ["Mock analysis"]}';
  }
}

void main() {
  withServerpod('Given AI endpoint', (sessionBuilder, endpoints) {
    final uuid = Uuid();
    final userId = uuid.v4obj();
    // final otherUserId = uuid.v4obj();
    
    // We need a way to access the mock instance to check captured values
    late MockGeminiService mockService;

    // Setup mock service
    setUp(() {
      mockService = MockGeminiService();
      GeminiService.mockInstance = mockService;
    });

    tearDown(() {
      GeminiService.mockInstance = null;
    });

    test('when chatting without authentication then works as guest', () async {
      final request = AiChatRequest(userInput: 'Hello');

      final response = await endpoints.ai.chat(sessionBuilder, request);
      expect(response.aiResponse, equals('Mock response for Hello'));
    });

    test('when chatting with authentication then returns response', () async {
      final authenticatedBuilder = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId.toString(),
          {},
        ),
      );

      final request = AiChatRequest(userInput: 'Hello');
      final response = await endpoints.ai.chat(authenticatedBuilder, request);

      expect(response.aiResponse, equals('Mock response for Hello'));
      expect(response.suggestedFollowups, contains('Mock suggestion'));
    });

    test('when chatting with sessionId then retrieves session docs and passes to service', () async {
      final authenticatedBuilder = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId.toString(),
          {},
        ),
      );

      final sessionId = 'test-session-123';

      // Create a doc in this session
      final doc = LegalDoc(
        userId: userId,
        sessionId: sessionId,
        title: 'Session Doc',
        content: 'Content of session doc',
        status: DocStatus.completed,
        type: DocType.general,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await endpoints.document.createDocument(authenticatedBuilder, doc);

      // Chat with sessionId
      final request = AiChatRequest(
        userInput: 'Analyze session',
        sessionId: sessionId,
      );

      final response = await endpoints.ai.chat(authenticatedBuilder, request);

      expect(response.aiResponse, equals('Mock response for Analyze session'));
      
      // Verify systemContext contained the doc info (Title and Summary only)
      expect(mockService.lastSystemContext, contains('Session Doc'));
      // Content is not included in system context list to save tokens
      // expect(mockService.lastSystemContext, contains('Content of session doc')); 
    });

    test('when chatting with inline newDocContent then creates doc and uses it', () async {
      final authenticatedBuilder = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId.toString(),
          {},
        ),
      );

      final request = AiChatRequest(
        userInput: 'Analyze this new doc',
        newDocName: 'Inline Doc.txt',
        newDocContent: 'Inline content here',
        sessionId: 'session-inline',
      );

      final response = await endpoints.ai.chat(authenticatedBuilder, request);

      expect(response.aiResponse, equals('Mock response for Analyze this new doc'));
      
      // The inline doc is passed as the ACTIVE document for analysis
      expect(mockService.lastDocName, equals('Inline Doc.txt'));
      expect(mockService.lastDocContent, contains('Inline content here'));
      
      // Verify doc was actually created in DB
      final docs = await endpoints.document.getDocumentsBySession(authenticatedBuilder, 'session-inline');
      expect(docs.length, equals(1));
      expect(docs.first.title, equals('Inline Doc.txt'));
      expect(docs.first.analysisJson, contains('"score": 85')); // Verified analysis ran
    });

    test('when chatting extensively then history is capped at 20 messages', () async {
      final authenticatedBuilder = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId.toString(),
          {},
        ),
      );

      String? contextId;
      
      // 12 turns (24 messages: 12 user + 12 bot)
      for (int i = 0; i < 12; i++) {
        final request = AiChatRequest(
          userInput: 'Turn $i',
          contextId: contextId,
        );
        final response = await endpoints.ai.chat(authenticatedBuilder, request);
        contextId = response.contextId;
      }

      final session = sessionBuilder.build();
      final cacheKey = 'chat_history_${userId}_$contextId';
      final cached = await session.caches.local.get(cacheKey);
      
      expect(cached, isNotNull);
      final history = cached as AiChatHistory;
      
      // Should be capped at 20
      expect(history.entries.length, equals(20));
      expect(history.entries.last.text, equals('Mock response for Turn 11'));
      expect(history.entries.first.text, equals('Turn 2'));
    });
  });
}
