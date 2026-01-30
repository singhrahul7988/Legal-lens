import 'package:test/test.dart';
import 'package:serverpod/serverpod.dart';
import 'package:legal_lens_server/src/generated/protocol.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Document endpoint', (sessionBuilder, endpoints) {
    final uuid = Uuid();
    final userId = uuid.v4obj();
    final otherUserId = uuid.v4obj();

    test('when creating document without authentication then throws exception', () async {
      final doc = LegalDoc(
        userId: userId, // Placeholder
        title: 'Test Doc',
        status: DocStatus.pending,
        type: DocType.general,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(
        endpoints.document.createDocument(sessionBuilder, doc),
        throwsA(isA<Exception>()),
      );
    });

    test('when creating document with authentication then returns document with correct userId', () async {
      final authenticatedBuilder = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId.toString(),
          {},
        ),
      );

      final doc = LegalDoc(
        userId: otherUserId, // Wrong ID, should be overwritten
        title: 'Test Doc',
        status: DocStatus.pending,
        type: DocType.general,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final createdDoc = await endpoints.document.createDocument(authenticatedBuilder, doc);

      expect(createdDoc.userId, equals(userId));
      expect(createdDoc.title, equals('Test Doc'));
    });

    test('when analyzing document of another user then throws exception', () async {
      final authenticatedBuilder = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId.toString(),
          {},
        ),
      );
      
      final otherAuthenticatedBuilder = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          otherUserId.toString(),
          {},
        ),
      );

      // Create doc as User 1
      final doc = LegalDoc(
        userId: userId,
        title: 'User 1 Doc',
        status: DocStatus.pending,
        type: DocType.general,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final createdDoc = await endpoints.document.createDocument(authenticatedBuilder, doc);

      // Try to analyze as User 2
      expect(
        endpoints.document.analyzeDocument(otherAuthenticatedBuilder, createdDoc.id!),
        throwsA(isA<Exception>()),
      );
    });
  });
}
