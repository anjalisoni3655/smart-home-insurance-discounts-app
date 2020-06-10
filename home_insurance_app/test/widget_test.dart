import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/main.dart';

import '../lib/pages/home.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Widget Test', (WidgetTester tester) async {
    await binding.setSurfaceSize(Size(640, 640));

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
   // login test

void main() async {
  testWidgets('Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    // Verify that our home page includes the introduction text .
    expect(
        find.text(
            "All your protection under one roof .Take Home Insurance now and secure your future. Don't forget to exlore the exciting discounts available "),
        findsOneWidget);
    );
    // Test for menu bar
    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
    await tester.pumpAndSettle();
    expect(find.text("Purchase Policy"), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 100));

    // Test for 'get_home_details Page'
    // Testing opening of the page . On tapping icon corresponding to Purchase policy , get_home_details page opens up
    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();
    expect(find.byType(RaisedButton), findsOneWidget);

    //Checking for all address inputs
    await tester.enterText(
        find.byKey(Key('First Adrress Line')), 'A-123 , Street Name');
    await tester.enterText(find.byKey(Key('Second Adrress Line')), 'Rohini');
    await tester.enterText(find.byKey(Key('City')), 'Delhi');
    await tester.enterText(find.byKey(Key('State')), 'Delhi');
    await tester.enterText(find.byKey(Key('Pincode')), '110033');

    //Checking the working of submit key
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle(); // to ensure enough time has passed
    expect(find.text("Available Policies"),
        findsOneWidget); //Takes to the policy page

    //Show Policies page
    // Check the working of the buttons
    await tester.tap(find.text('View Smart Device Discounts'));
    await tester.pumpAndSettle();
    expect(find.text('Available Discounts'),
        findsOneWidget); // Takes to the discount page
  });
}
