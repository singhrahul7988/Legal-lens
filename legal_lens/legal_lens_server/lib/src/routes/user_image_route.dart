import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class UserImageRoute extends Route {
  @override
  Future<Result> handleCall(Session session, Request request) async {
    // URL: /user_image/<userId>
    final segments = request.url.pathSegments;
    if (segments.length < 2) {
      return Response.badRequest();
    }

    final userIdStr = segments.last;
    UuidValue userId;
    try {
      userId = UuidValue.fromString(userIdStr);
    } catch (e) {
      return Response.badRequest();
    }

    final userImage = await UserImageData.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );

    if (userImage == null) {
      return Response.notFound();
    }

    try {
      final bytes = base64Decode(userImage.data);
      // userImage.mimeType is like "image/png"
      final mimeParts = userImage.mimeType.split('/');
      final mimeType = MimeType(mimeParts[0], mimeParts[1]);
      
      return Response.ok(
        body: Body.fromData(
          bytes,
          mimeType: mimeType,
        ),
      );
    } catch (e) {
      return Response.internalServerError();
    }
  }
}
