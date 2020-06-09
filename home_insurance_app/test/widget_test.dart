import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:homeinsuranceapp/main.dart';

import '../lib/pages/home.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {

    await tester.pumpWidget(HomePage());

    expect(
        find.text(
            "All your protection under one roof .Take Home Insurance now and secure your future. Don't forget to exlore the exciting discounts available "),
        findsOneWidget);
  });
}