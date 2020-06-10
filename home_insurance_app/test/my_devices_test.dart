import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/main.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/my_devices.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(MaterialApp(
      home: MyDevices(),
    ));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(Icon), findsNWidgets(4));
  });
}
