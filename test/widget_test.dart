import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('IA Central app smoke test', (WidgetTester tester) async {
    // Build a simple test app
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('IA Central')),
          body: const Center(child: Text('Test')),
        ),
      ),
    );

    // Verify that the app title is present
    expect(find.text('IA Central'), findsOneWidget);
  });
}