import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/data/purchase_dao.dart';
import 'package:homeinsuranceapp/pages/get_home_details.dart';
import 'package:homeinsuranceapp/pages/payment_history.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;

void main() {
  // setting up a demo database instance for test
  setUpAll(() {
    globals.purchaseDao = PurchaseDao(Firestore.instance);
    globals.user = globals.User();
    globals.user.userId = '153246253t3bghhjg';
  });
  testWidgets('Purchase History Tests', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PurchaseHistory(),
        routes: {
          '/gethomedetails': (context) => HomeDetails(),
        },
      ),
    );

    expect(find.byType(Text), findsNWidgets(4));
    expect(find.byType(RaisedButton), findsOneWidget);

    await tester.tap(find.byType(RaisedButton));

    await tester.pump();
    await tester.pump();
    await tester.pump(Duration(seconds: 1));

    expect(find.byType(HomeDetails), findsOneWidget);
  });
}
