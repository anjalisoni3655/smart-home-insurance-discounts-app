import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/pages/payment_page.dart';

void main() {


  testWidgets('PaymentPage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Payment(),
    ));



    
//    expect(find.byType(TextWidget), findsNWidgets(7));
   expect(find.byKey(Key('name')), findsOneWidget);
    //Finds Button
    expect(find.byType(RaisedButton), findsOneWidget);

    //Checks whether Navigator gets pushed or not
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();



   // expect(find.byType(ConfirmPayment), findsOneWidget);
  });
}
