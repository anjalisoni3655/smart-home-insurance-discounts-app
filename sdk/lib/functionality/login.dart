library sdk;

import 'dart:async';
import 'package:sdk/User.dart';
import 'package:sdk/mock_api/google_sign_in_api.dart';

class Login {
  // User will have to enter email and password
  Duration loginTimeoutDuration;
  Duration logoutTimeoutDuration;
  Duration isSignedInTimeoutDuration;

  int testing;
  GoogleSignInAPI googleSignInAPI;

  Login(
      {this.testing = 0,
      this.loginTimeoutDuration = const Duration(minutes: 1),
      this.logoutTimeoutDuration = const Duration(seconds: 1),
      this.isSignedInTimeoutDuration = const Duration(seconds: 1)}) {
    googleSignInAPI = GoogleSignInAPI(testing: testing);
  }

  Future<String> login() async {
    // returns status "login successful", "login failed", "login time-out", "already logged in"
    try {
      if (await googleSignInAPI
          .isSignedIn()
          .timeout(isSignedInTimeoutDuration)) {
        return "already logged in";
      }
      await googleSignInAPI.signIn().timeout(loginTimeoutDuration);
      return "login successful";
    } catch (error) {
      return "login failed";
    }
  }

  Future<String> logout() async {
    // returns status "logout successful", "logout failed", "logout timed-out", "not logged in"
    try {
      if (!(await googleSignInAPI
          .isSignedIn()
          .timeout(isSignedInTimeoutDuration))) {
        return "not logged in";
      }
      await googleSignInAPI.disconnect().timeout(logoutTimeoutDuration);
      return "logout successful";
    } catch (error) {
      return "logout failed";
    }
  }

  Future<User> getUserDetails() async {
    if (!(await googleSignInAPI.isSignedIn())) return null;
    return googleSignInAPI.currentUser;
  }
}
