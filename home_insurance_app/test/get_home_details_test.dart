import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/pages/get_home_details.dart';
import 'package:homeinsuranceapp/data/policy_dao.dart';

void main() {
  testWidgets('1. Test for getting home address details',
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
//    await tester.tap(submitButton);
//    await tester.pumpAndSettle();

//    //Check that in all input fields text could be entered
    await tester.enterText(
        find.byKey(Key('First Address Line')), 'A-123 , Street Name');
    await tester.enterText(find.byKey(Key('Second Address Line')), 'Rohini');
    await tester.enterText(find.byKey(Key('City')), 'Delhi');
    await tester.enterText(find.byKey(Key('State')), 'Delhi');
    await tester.enterText(find.byKey(Key('Pincode')), '110033');
  });

  test('2 .Valid address test', () {
    String address1 = 'Kidwai Nagar';
    var result = validateAddress(address1);
    expect(result, null);
  });

  test('3. Invalid address test', () {
    String address2 = '*!';
    var result = validateAddress(address2);
    expect(result, 'Please enter a valid address');
  });

  test('4. Empty address test', () {
    var result = validateAddress('');
    expect(result, 'This Field cannot be empty');
  });

  test('5. Empty pincode test', () {
    var result = validatePincode('');
    expect(result, 'This field cannot be empty');
  });

  test('6. Invalid pincode test', () {
    var result = validatePincode('900');
    expect(result, 'Please enter a valid pincode');
  });

  test('7. Invalid pincode with special characters', () {
    var result = validatePincode('12345_');
    expect(result, 'Please enter a valid pincode');
  });

  test('8. Valid pincode test', () {
    var result = validatePincode('208022');
    expect(result, null);
  });
}
