import 'package:uuid/uuid.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  final String sessionId = const Uuid().v4();
}
