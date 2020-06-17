import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/pages/get_home_details.dart';

void main() {
  testWidgets('Test for getting home address details',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeDetails(),
      ),
    );

    // Test for presence and tapping of  the Submit Button
    // Since the form will not be submitted , tapping submit button will not take us to other page
    final submitButton = find.text("SUBMIT");
    expect(submitButton, findsOneWidget);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

//    //Check that in all input fields text could be entered
    await tester.enterText(
        find.byKey(Key('First Address Line')), 'A-123 , Street Name');
    await tester.enterText(find.byKey(Key('Second Address Line')), 'Rohini');
    await tester.enterText(find.byKey(Key('City')), 'Delhi');
    await tester.enterText(find.byKey(Key('State')), 'Delhi');
    await tester.enterText(find.byKey(Key('Pin-code')), '110033');
  });
}
