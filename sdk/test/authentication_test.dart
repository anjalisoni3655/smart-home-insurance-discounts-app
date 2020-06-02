library sdk;

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sdk/User.dart';
import 'package:sdk/authentication.dart';

void main() {
  test('test 1: api logging in and loggin out properly', () async {
    Authentication authentication = new Authentication(testing: 1);
    expect(await authentication.logout(), "not logged in");
    expect(await authentication.getUserDetails(), null);
    expect(await authentication.login(), "login successful");
    expect(await authentication.getUserDetails(), new User(displayName: "Osheen Sachdev", email: "osheen@google.com", photoUrl: "someurl.com"));
    expect(await authentication.login(), "already logged in");
    expect(await authentication.logout(), "logout successful");
    expect(await authentication.getUserDetails(), null);
  });
  test('test 2: api throwing an error on logging in', () async {
    Authentication authentication = new Authentication(testing: 2);
    expect(await authentication.login(), "login failed");
    expect(await authentication.getUserDetails(), null);
  });
  test('test 3: api throwing an error on logging out', () async {
    Authentication authentication = new Authentication(testing: 3);
    expect(await authentication.login(), "login successful");
    expect(await authentication.getUserDetails(), new User(displayName: "Osheen Sachdev", email: "osheen@google.com", photoUrl: "someurl.com"));
    expect(await authentication.logout(), "logout failed");
    expect(await authentication.getUserDetails(), new User(displayName: "Osheen Sachdev", email: "osheen@google.com", photoUrl: "someurl.com"));
  });

}
