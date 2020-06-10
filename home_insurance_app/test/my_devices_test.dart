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

    expect(find.byType(FloatingActionButton), findsNWidget);
    await tester.tap(find.byIcon(Icons.devices_other));
    await tester.pumpAndSettle();
    
    expect(find.byType(FloatingActionButton), findsNWidget);
    await tester.tap(find.byIcon(Icons.smoke_free));
    await tester.pumpAndSettle();
    
    expect(find.byType(FloatingActionButton), findsNWidget);
    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();
    
    expect(find.byType(FloatingActionButton), findsNWidget);
    await tester.tap(find.byIcon(Icons.camera_alt));
    await tester.pumpAndSettle();
    
  });
}
