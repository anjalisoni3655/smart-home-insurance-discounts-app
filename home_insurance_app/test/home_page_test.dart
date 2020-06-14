import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:homeinsuranceapp/pages/login_screen.dart';
import 'package:homeinsuranceapp/pages/profile.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
      ),
    );

    expect(
        find.text(
            "All your protection under one roof .Take Home Insurance now and secure your future. Don't forget to exlore the exciting discounts available "),
        findsOneWidget);
    //Test for the Pop Up Button 
    await tester.tap(find.byKey(Key('popmenu key')));
    await tester.pumpAndSettle();
    expect(find.text("Logout"), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    
    // Test for menu bar
    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
    await tester.pumpAndSettle();
    expect(find.text("Purchase Policy"), findsOneWidget);
    expect(find.text('Smart Devices Discounts'), findsOneWidget);
    expect(find.text('My Devices'), findsOneWidget);
    expect(find.text('Contact Us'), findsOneWidget);
    
  });
}
