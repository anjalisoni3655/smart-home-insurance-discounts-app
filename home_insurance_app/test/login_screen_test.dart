import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:homeinsuranceapp/main.dart';

import 'package:homeinsuranceapp/pages/login_screen.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    expect(find.text("Log in to Continue"), findsOneWidget);
    await tester.tap(find.byKey(Key('signIn')));

  });
}
