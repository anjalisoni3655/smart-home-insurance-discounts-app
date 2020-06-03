library sdk;

import 'dart:async';
import 'package:sdk/User.dart';
import 'package:sdk/mock_api/google_sign_in_api.dart';

class Login {
  static const int LOGIN_TIMEOUT_DURATION =
      60; // User will have to enter email and password
  static const int LOGOUT_TIMEOUT_DURATION = 3;

  int testing;
  GoogleSignInAPI googleSignInAPI;

  Login({this.testing = 0}) {
    googleSignInAPI = GoogleSignInAPI(testing: testing);
  }

  Future<String> login() async {
    // returns status "login successful", "login failed", "login time-out", "already logged in"
    if (await googleSignInAPI.isSignedIn()) {
      return "already logged in";
    }
    try {
      await googleSignInAPI
          .signIn()
          .timeout(const Duration(seconds: LOGIN_TIMEOUT_DURATION));
      return "login successful";
    } catch (error) {
      return "login failed";
    }
  }

  Future<String> logout() async {
    // returns status "logout successful", "logout failed", "logout timed-out", "not logged in"
    if(!(await googleSignInAPI.isSignedIn())) {
      return "not logged in";
    }
    try {
      await googleSignInAPI
          .disconnect()
          .timeout(const Duration(seconds: LOGOUT_TIMEOUT_DURATION));
      return "logout successful";
    } catch (error) {
      return "logout failed";
    }
  }
  Future<User> getUserDetails() async {
    if(!(await googleSignInAPI.isSignedIn())) return null;
    return googleSignInAPI.currentUser;
  }
}
