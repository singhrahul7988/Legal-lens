import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  
  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal();

  late String _sessionId;
  
  String get sessionId => _sessionId;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedSessionId = prefs.getString('legal_lens_session_id');
    
    if (storedSessionId == null) {
      storedSessionId = const Uuid().v4();
      await prefs.setString('legal_lens_session_id', storedSessionId);
    }
    
    _sessionId = storedSessionId;
  }

  /// Resets the session ID (useful for "Clear Context" or starting fresh)
  Future<void> resetSession() async {
    final prefs = await SharedPreferences.getInstance();
    final newSessionId = const Uuid().v4();
    await prefs.setString('legal_lens_session_id', newSessionId);
    _sessionId = newSessionId;
  }
}
