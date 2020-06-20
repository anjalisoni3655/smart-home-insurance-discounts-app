import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/show_discounts.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

void main() {
  setUp(() async {
    await globals.initialise(test: true);
  });

  testWidgets('Show Discounts before access', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(MaterialApp(
      home: DisplayDiscounts(),
    ));

    final head1 = find.text('Available Offers');
    expect(head1, findsOneWidget);

    final button1 = find.text('Link Devices');
    final button2 = find.text('Go to Payment');
    expect(button1, findsOneWidget);
    expect(button2, findsOneWidget);

    // TODO: Mock firebase and add tests
  });
}
