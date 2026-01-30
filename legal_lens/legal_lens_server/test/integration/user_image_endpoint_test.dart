import 'dart:convert';
import 'package:test/test.dart';
import 'package:serverpod/serverpod.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given UserImage endpoint', (sessionBuilder, endpoints) {
    final uuid = Uuid();
    final userId = uuid.v4obj();
    final testImageBase64 = base64Encode(utf8.encode('fake_image_data'));
    final testMimeType = 'image/png';

    test('when uploading user image without authentication then throws exception', () async {
      expect(
        endpoints.userImage.updateUserImage(sessionBuilder, testImageBase64, testMimeType),
        throwsA(isA<Exception>()),
      );
    });

    test('when uploading user image with authentication then returns image URL', () async {
      final authenticatedBuilder = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId.toString(),
          {},
        ),
      );

      final imageUrl = await endpoints.userImage.updateUserImage(
        authenticatedBuilder,
        testImageBase64,
        testMimeType,
      );

      expect(imageUrl, contains('/user_image/${userId.uuid}'));
    });

    test('when removing user image then succeeds', () async {
      final authenticatedBuilder = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId.toString(),
          {},
        ),
      );

      // Upload first
      await endpoints.userImage.updateUserImage(
        authenticatedBuilder,
        testImageBase64,
        testMimeType,
      );

      // Remove
      await endpoints.userImage.removeUserImage(authenticatedBuilder);

      // Verify removal (get should return null)
      final url = await endpoints.userImage.getProfileImageUrl(authenticatedBuilder);
      expect(url, isNull);
    });
  });
}
