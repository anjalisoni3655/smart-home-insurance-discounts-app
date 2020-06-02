library sdk;
import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
//import 'package:sdk/user.dart';

class Authentication {
  static const int LOGIN_TIMEOUT_DURATION = 60; // User will have to enter email and password
  static const int LOGOUT_TIMEOUT_DURATION = 3;

  GoogleSignIn _googleSignIn;

  Authentication() {
    _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
  }

  Future<String> login() async {
    // returns status "login successful", "login failed", "login time-out", "already logged in"
    try{
      await _googleSignIn.signIn().timeout(const Duration(seconds: LOGIN_TIMEOUT_DURATION));
      return "login successful";
    } catch (error) {
      return "login failed";
    }

  }
  Future<String> logout() async {
    // returns status "logout successful", "logout failed", "logout timed-out", "not logged in"
    await _googleSignIn.disconnect().timeout(const Duration(seconds: LOGOUT_TIMEOUT_DURATION));

  }
//  User getUserDetails() {
//    // returns an instance of class User
//  }
}