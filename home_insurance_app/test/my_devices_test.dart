import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/my_devices.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;

const device1Name = 'device-1-name';
const device2Name = 'device-2-name';

void main() {
  setUp(() async {
    globals.sdk = await globals.initialiseSDK(test: true);
  });

  testWidgets('My Devices when SDK returns devices normally', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(MaterialApp(
      home: MyDevices(),
    ));

    Finder linkDevicesButton = find.text("Link Devices");
    await tester.tap(linkDevicesButton);
    await tester.pumpAndSettle();

    Finder device1 = find.text('$device1Name');
    Finder device2 = find.text('$device2Name');
    expect(device1, findsOneWidget);
    expect(device2, findsOneWidget);
  });
}
