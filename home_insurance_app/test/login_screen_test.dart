import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/login_screen.dart';
import 'package:homeinsuranceapp/main.dart';

void main() {
  testWidgets('Main UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
