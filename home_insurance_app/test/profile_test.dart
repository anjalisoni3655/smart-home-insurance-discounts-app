import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/pages/profile.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Test my profile page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Profile(),
    ));

    expect(find.text('Mr. XYZ'), findsOneWidget);
    expect(find.text('Business Analyst'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(2));
  });
}
