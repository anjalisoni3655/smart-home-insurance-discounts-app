import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/show_discounts.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:mockito/mockito.dart';
import 'package:sdk/sdk.dart';

class MockSDK extends Mock implements SDK {}

void main() {
  setUp(() {
    globals.sdk = new MockSDK();
  });

  testWidgets('Show Discounts before access', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    when(globals.sdk.getCredentials()).thenReturn({'accessToken': null, 'refreshToken': null});

    await tester.pumpWidget(MaterialApp(
      home: DisplayDiscounts(),
    ));

    final head1 = find.text('Available Offers');
    expect(head1, findsOneWidget);

    //Check the absence of Payment and Get Discounts Button ( Since this page is directly tested , selected policy  will be null and payment buttons should not be shown )
    final button1 = find.text('Link Devices');
    final button2 = find.text('Go to Payment');
    expect(button1, findsNothing);
    expect(button2, findsNothing);

    //Check for one or more discount cards
    final card = find.byType(Card);
    expect(card, findsWidgets);
  });

  testWidgets("Show Discounts after access", (WidgetTester tester) async {
    // Build our app and trigger a frame.

    when(globals.sdk.getCredentials()).thenReturn({'accessToken': 'accessToken', 'refreshToken': 'refreshToken'});

    await tester.pumpWidget(MaterialApp(
      home: DisplayDiscounts(),
    ));

    final head1 = find.text('Available Offers');
    expect(head1, findsOneWidget);

    //Check the absence of Payment and Get Discounts Button ( Since this page is directly tested , selected policy  will be null and payment buttons should not be shown )
    final button1 = find.text('Pick Structure');
    final button2 = find.text('Go to Payment');
    expect(button1, findsNothing);
    expect(button2, findsNothing);

    //Check for one or more discount cards
    final card = find.byType(Card);
    expect(card, findsWidgets);
  });
}
