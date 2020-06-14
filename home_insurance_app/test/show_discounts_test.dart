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

    //Check the presence of two buttons
    final button1 = find.byIcon(Icons.money_off);
    final button2 = find.byIcon(Icons.arrow_forward);
    expect(button1, findsOneWidget);
    expect(button2, findsOneWidget);
    

  });
}
