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
  test("test 3: api taking 200 ms to login and 200 ms to logout than timeout set", () async {
    Login login = new Login(testing: 4, loginTimeoutDuration: new Duration(milliseconds: 100));
    expect(await login.login(), "login failed");
    login = new Login(testing: 4, loginTimeoutDuration: new Duration(milliseconds: 300), logoutTimeoutDuration: new Duration(milliseconds: 100));
    expect(await login.login(), "login successful");
    expect(await login.logout(), "logout failed");
    login = new Login(testing: 4, loginTimeoutDuration: new Duration(milliseconds: 300), logoutTimeoutDuration: new Duration(milliseconds: 300));
    expect(await login.login(), "login successful");
    expect(await login.logout(), "logout successful");
  });
  test("test 5: api taking 200 ms to respond to isSignedIn", () async {
    Login login = new Login(testing: 5, isSignedInTimeoutDuration: new Duration(milliseconds: 100));
    expect(await login.login(), "login failed");
  });
}
