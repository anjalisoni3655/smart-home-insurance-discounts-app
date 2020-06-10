import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:homeinsuranceapp/main.dart';

<<<<<<< HEAD
import '../lib/pages/home.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomePage(),
    ));

=======
void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    // Verify that our home page includes the introduction text .
>>>>>>> d97e464f613540290a426bb2ddfeda82530e211b
    expect(
        find.text(
            "All your protection under one roof .Take Home Insurance now and secure your future. Don't forget to exlore the exciting discounts available "),
        findsOneWidget);
  });
}
