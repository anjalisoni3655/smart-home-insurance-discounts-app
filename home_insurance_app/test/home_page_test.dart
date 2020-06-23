import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/pages/home.dart';

void main() {
  testWidgets('Home Page Widget Test ', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
      ),
    );

    var homePageButtons = find.byType(RaisedButton);
    expect(homePageButtons, findsNWidgets(2));

    // Test for the Pop Up Button
    var popUpButton = find.byIcon(Icons.accessibility);
    expect(popUpButton, findsOneWidget);

    await tester.tap(popUpButton);
    await tester.pumpAndSettle();

    var childButton = find.text('Logout');
    expect(childButton, findsOneWidget);
    var childButton2 = find.text('My Profile');
    expect(childButton2, findsOneWidget);

    // To remove the pop up from the screen , tap anywhere else on the screen
    var homeScreen = find.byKey(Key("appBar"));
    await tester.tap(homeScreen);

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
