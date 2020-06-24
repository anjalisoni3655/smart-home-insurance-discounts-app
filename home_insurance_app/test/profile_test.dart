import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/pages/profile.dart';

void main() {
  // sets up an http client for http requests
  setUpAll(() => HttpOverrides.global = null);

  testWidgets('Profile Page Tests', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Profile(),
    ));

    expect(find.byKey(Profile.nameKey), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(4));
  });
}
