import 'package:contactus/contactus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/pages/contact.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('ContactUs package gets displayed with necessary items',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: Contact()));

    // Displays ContactUs widget
    expect(find.byType(ContactUs), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });

  testWidgets('OnClicking the website button it opens the url',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Contact()));

    await tester.tap(find.text('Website'));
    await tester.pumpAndSettle();
  });
}
