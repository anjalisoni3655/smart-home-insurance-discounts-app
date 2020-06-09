import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:homeinsuranceapp/main.dart';

import '../lib/pages/home.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomePage(),
    ));

    expect(
        find.text(
            "All your protection under one roof .Take Home Insurance now and secure your future. Don't forget to exlore the exciting discounts available "),
        findsOneWidget);
    //expect(find.byType(PopupMenuButton), findsOneWidget);

    //var mainButton = find.byType(PopupMenuButton);
    //expect(mainButton, findsOneWidget);

    //await tester.tap(mainButton);
    //await tester.pumpAndSettle();

    //var childButton = find.text('Logout');
    //expect(childButton , findsOneWidget); //
    //var childButton2 = find.text('MY Profile');
    //expect(childButton2 , findsOneWidget); //
  });
}
