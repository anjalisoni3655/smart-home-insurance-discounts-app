library sdk;
import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
//import 'package:sdk/user.dart';

class Authentication {
  static const int LOGIN_TIMEOUT_DURATION = 60; // User will have to enter email and password
  static const int LOGOUT_TIMEOUT_DURATION = 3;

  int testing;
  GoogleSignInAPI googleSignInAPI;

  Authentication({this.testing = 0}) {
    googleSignInAPI = GoogleSignInAPI(testing: testing);
  }

  Future<String> login() async {
    // returns status "login successful", "login failed", "login time-out", "already logged in"
    try{
      await googleSignInAPI.signIn().timeout(const Duration(seconds: LOGIN_TIMEOUT_DURATION));
      return "login successful";
    } catch (error) {
      return "login failed";
    }

  }
  Future<String> logout() async {
    // returns status "logout successful", "logout failed", "logout timed-out", "not logged in"
    try {
      await googleSignInAPI.disconnect().timeout(const Duration(seconds: LOGOUT_TIMEOUT_DURATION));
      return "logout successful";
    } catch (error) {
      return "logout failed";
    }


  }
//  User getUserDetails() {
//    // returns an instance of class User
//  }
}

// For testing purpose
// Behaves exactly like GoogleSignIn object if testing = 0
// Behaves otherwise if testing != 0 (can define test cases for them)
class GoogleSignInAPI {
  GoogleSignIn _googleSignIn;
  int testing;
  GoogleSignInAPI({this.testing = 0}) {
    if(testing == 0) {
      _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
    }
  }

  Future<void> signIn() async {
    if(testing == 0) {
      await _googleSignIn.signIn();
    }
    else if(testing == 1) {
      return;
    }
  }
  Future<void> disconnect() async {
    if(testing == 0) {
      await _googleSignIn.disconnect();
    }
    if(testing == 1) {
      return;
    }
  }

}