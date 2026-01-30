import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class UserImageEndpoint extends Endpoint {
  // Allow public access so getProfileImageUrl returns null for guests instead of 401
  // Specific methods enforce auth manually
  
  Future<String> updateUserImage(Session session, String base64Content, String mimeType) async {
    final authInfo = session.authenticated;
    final userId = authInfo?.authUserId;
    
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    // Check if image exists
    var existingImage = await UserImageData.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );

    if (existingImage != null) {
      existingImage.data = base64Content;
      existingImage.mimeType = mimeType;
      await UserImageData.db.updateRow(session, existingImage);
    } else {
      await UserImageData.db.insertRow(
        session,
        UserImageData(
          userId: userId,
          data: base64Content,
          mimeType: mimeType,
        ),
      );
    }

    final config = session.serverpod.config;
    final webPort = config.webServer!.publicPort;
    final webHost = config.webServer!.publicHost;
    final scheme = config.webServer!.publicScheme;
    
    final imageUrl = '$scheme://$webHost:$webPort/user_image/${userId.uuid}';

    return imageUrl;
  }

  Future<String?> getProfileImageUrl(Session session) async {
    final authInfo = session.authenticated;
    final userId = authInfo?.authUserId;
    
    if (userId == null) {
      return null;
    }

    final existingImage = await UserImageData.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );

    if (existingImage == null) {
      return null;
    }

    final config = session.serverpod.config;
    final webPort = config.webServer!.publicPort;
    final webHost = config.webServer!.publicHost;
    final scheme = config.webServer!.publicScheme;
    
    return '$scheme://$webHost:$webPort/user_image/${userId.uuid}';
  }

  Future<void> removeUserImage(Session session) async {
    final authInfo = session.authenticated;
    // Guest Mode: Use a fixed UUID for all operations
    final userId = authInfo?.authUserId ?? UuidValue.fromString('00000000-0000-0000-0000-000000000000');
    
    final existingImage = await UserImageData.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );

    if (existingImage != null) {
      await UserImageData.db.deleteRow(session, existingImage);
    }
  }
}
