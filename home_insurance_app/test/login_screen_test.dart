import 'package:flutter_test/flutter_test.dart';

import 'package:homeinsuranceapp/pages/login_screen.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(LoginScreen());
    final titleFinder = find.text('Smart Home');
    final messageFinder = find.text('Log in to Continue');
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
