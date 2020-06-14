import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/pages/choose_policy.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DisplayPolicies(),
      ),
    );

    final head1 = find.text('Available Policies');
    expect(head1, findsOneWidget);

    //Check presence and tapping  of  buttons
    final buttons = find.byIcon(Icons.payment);
    expect(buttons, findsNWidgets(2));
    expect(find.text("Payment"), findsOneWidget);
    expect(find.text('View Smart Device Discounts'), findsOneWidget);
  });
}
