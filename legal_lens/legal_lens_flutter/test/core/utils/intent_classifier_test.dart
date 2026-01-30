import 'package:flutter_test/flutter_test.dart';
import 'package:legal_lens_flutter/core/utils/intent_classifier.dart';

void main() {
  group('IntentClassifier', () {
    test('detects general switch', () {
      expect(IntentClassifier.classify('Please switch to general mode', true), IntentType.general);
      expect(IntentClassifier.classify('Stop analyzing this', true), IntentType.general);
    });

    test('detects specific switch when docs exist', () {
      expect(IntentClassifier.classify('Check my file', true), IntentType.specific);
      expect(IntentClassifier.classify('Analyze document', true), IntentType.specific);
    });

    test('ignores specific switch when docs missing', () {
      expect(IntentClassifier.classify('Check my file', false), IntentType.unknown);
    });

    test('returns unknown for random text', () {
      expect(IntentClassifier.classify('Hello world', true), IntentType.unknown);
    });
  });
}
