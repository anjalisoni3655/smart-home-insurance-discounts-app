import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/pages/contact.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Contact(),
    ));
  });
}
