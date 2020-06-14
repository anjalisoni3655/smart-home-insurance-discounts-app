import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/main.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/show_discounts.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(MaterialApp(
      home: DisplayDiscounts(),
    ));

    final head1 = find.text('Available Discounts');
    expect(head1, findsOneWidget);

    //Check the absence of Payment and Get Discounts Button ( Since this page is directly tested , selected policy  will be null and payment buttons should not be shown )
    final button1 = find.text('Get Discounts');
    final button2 = find.text('Go to Payment');
    expect(button1, findsNothing);
    expect(button2, findsNothing);

    //Check for one or more discount cards
    final card = find.byType(Card);
    expect(card, findsWidgets);
  });
}
