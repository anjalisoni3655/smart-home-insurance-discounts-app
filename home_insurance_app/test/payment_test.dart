import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/data/user_home_details.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';
import 'package:homeinsuranceapp/pages/payment_page.dart';

void main() {
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  final ValueKey buttonKey = ValueKey('button_key');
  final Offer selectedOffer = Offer({'test': 1}, 2);
  final Policy selectedPolicy = Policy('tenants-policy', 5, 1000);
  final UserAddress userAddress =
      UserAddress('first_address', 'second_address', 'city', 'state', 208022);

  testWidgets('PaymentPage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      navigatorKey: key,
      routes: {
        Payment.id: (context) => Payment(),
      },
      home: Scaffold(
        body: Center(
            child: FlatButton(
          key: buttonKey,
          child: Text("A"),
          onPressed: () => key.currentState.pushNamed(Payment.id, arguments: {
            'selectedOffer': selectedOffer,
            'selectedPolicy': selectedPolicy,
            'userAddress': userAddress,
          }),
        )),
      ),
    ));

    // Navigate to the Payment page with the given arguments
    await tester.tap(find.byKey(buttonKey));
    await tester.pump();
    await tester.pump();
    await tester.pump(Duration(seconds: 1));

    // Testing whether TextWidgets are painted or not

    expect(find.byType(ListTile), findsNWidgets(6));

    // testing the RaisedButton
    expect(find.byType(RaisedButton), findsNWidgets(2));
  });
}
