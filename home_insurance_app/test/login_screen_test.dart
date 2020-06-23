import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:homeinsuranceapp/pages/login_screen.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  NavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  testWidgets('LoginPage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(),
      navigatorObservers: [mockObserver],
    ));

    verify(mockObserver.didPush(any, any));

    final titleFinder = find.text('Get your smart home secured today!');
    final messageFinder = find.text('Log In With Google');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
    //Finds Button
    expect(find.byType(RaisedButton), findsOneWidget);
  });
}
