import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/pages/home.dart';


void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
      ),
    );


    var maintext = find.text(
        "All your protection under one roof .Take Home Insurance now and secure your future. Don't forget to exlore the exciting discounts available ");

    expect(maintext,findsOneWidget);

   // Test for the Pop Up Button
    var popUpButton = find.byIcon(Icons.accessibility);
    expect(popUpButton, findsOneWidget);

    await tester.tap(popUpButton);
    await tester.pumpAndSettle();

    var childButton = find.text('Logout');
    expect(childButton , findsOneWidget);
    var childButton2 = find.text('My Profile');
    expect(childButton2 , findsOneWidget);

    // To remove the pop up from the screen , tap anywhere else on the screen
    await tester.tap(maintext);
    await tester.pumpAndSettle();

    // Test for Menu Bar

    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
    await tester.pumpAndSettle();
    expect(find.text("Purchase Policy"), findsOneWidget);
    expect(find.text('Smart Devices Discounts'), findsOneWidget);
    expect(find.text('My Devices'), findsOneWidget);
    expect(find.text('Contact Us'), findsOneWidget);
    
  });
}
