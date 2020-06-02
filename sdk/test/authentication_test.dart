library sdk;
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sdk/authentication.dart';

void main() {
  test('test 1', () async {
    Authentication authentication = new Authentication(testing: 1);
    expect(await authentication.logout(), "not logged in");
    expect(await authentication.login() , "login successful");
    expect(await authentication.login(), "already logged in");
    expect(await authentication.logout(), "logout successful");
  });
}
