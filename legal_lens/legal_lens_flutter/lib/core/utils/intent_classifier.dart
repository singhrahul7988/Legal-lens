enum IntentType { general, specific, unknown }

class IntentClassifier {
  static IntentType classify(String text, bool hasDocuments) {
    final lower = text.toLowerCase();
    if (lower.contains("switch to general") || lower.contains("stop analyzing")) {
      return IntentType.general;
    }
    if (hasDocuments && (lower.contains("check my file") || lower.contains("analyze document"))) {
      return IntentType.specific;
    }
    return IntentType.unknown;
  }
}
