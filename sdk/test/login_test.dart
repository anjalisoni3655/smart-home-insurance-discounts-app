library sdk;

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sdk/User.dart';
import 'package:sdk/functionality/login.dart';

void main() {
  test('test 1: api logging in and loggin out properly', () async {
    Login login = new Login(testing: 1);
    expect(await login.logout(), "not logged in");
    expect(await login.getUserDetails(), null);
    expect(await login.login(), "login successful");
    expect(await login.getUserDetails(), new User(displayName: "Osheen Sachdev", email: "osheen@google.com", photoUrl: "someurl.com"));
    expect(await login.login(), "already logged in");
    expect(await login.logout(), "logout successful");
    expect(await login.getUserDetails(), null);
  });
  test('test 2: api throwing an error on logging in', () async {
    Login login = new Login(testing: 2);
    expect(await login.login(), "login failed");
    expect(await login.getUserDetails(), null);
  });
  test('test 3: api throwing an error on logging out', () async {
    Login login = new Login(testing: 3);
    expect(await login.login(), "login successful");
    expect(await login.getUserDetails(), new User(displayName: "Osheen Sachdev", email: "osheen@google.com", photoUrl: "someurl.com"));
    expect(await login.logout(), "logout failed");
    expect(await login.getUserDetails(), new User(displayName: "Osheen Sachdev", email: "osheen@google.com", photoUrl: "someurl.com"));
  });

}
