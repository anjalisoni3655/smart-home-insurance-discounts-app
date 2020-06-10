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
  });

  testWidgets('PopmenuButton is visible and handles gestures',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: HomePage()),
    );

    expect(find.byKey(HomePage.popmenuButton), findsOneWidget);

    await tester.tap(find.byKey(HomePage.popmenuButton));
    await tester.pumpAndSettle();

    expect(find.text('Logout'), findsOneWidget);
    expect(find.text('My Profile'), findsOneWidget);
  });

  testWidgets(
      'PopmenuButton navigates to the desired screen on pressing LOGOUT',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    await tester.tap(find.byKey(HomePage.popmenuButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Logout'));
    await tester.pump();
    await tester.pump();
    await tester.pump(Duration(seconds: 1));

    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets(
      'PopmenuButton navigates to the desired screen on pressing My_PROFILE',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    await tester.tap(find.byKey(HomePage.popmenuButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('My Profile'));
    await tester.pump();
    await tester.pump();
    await tester.pump(Duration(seconds: 1));

    expect(find.byType(Profile), findsOneWidget);
  });
}
