import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:legal_lens_flutter/screens/dashboard_screen.dart';

void main() {
  testWidgets('TypewriterText displays text and removes cursor after completion', (WidgetTester tester) async {
    const testPhrase = "How can I help you today?";
    
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TypewriterText(
            phrases: [testPhrase],
            textStyle: TextStyle(fontSize: 20),
            typingSpeed: Duration(milliseconds: 1), // Fast for test
          ),
        ),
      ),
    );

    // Initial state: Empty text with cursor
    expect(find.text("|"), findsOneWidget);

    // Pump frames to simulate typing
    // Length of phrase + 1 for completion
    for (int i = 0; i <= testPhrase.length; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    // Final state: Full text WITHOUT cursor
    expect(find.text(testPhrase), findsOneWidget);
    expect(find.text("$testPhrase|"), findsNothing);
  });
}
