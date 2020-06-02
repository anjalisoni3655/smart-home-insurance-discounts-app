library sdk;

import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdk/User.dart';

//import 'package:sdk/user.dart';

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

// For testing purpose
// Behaves exactly like GoogleSignIn object if testing = 0
// Behaves otherwise if testing != 0 (can define test cases for them)
class GoogleSignInAPI {
  GoogleSignIn _googleSignIn;
  int testing;
  bool signedIn;

  GoogleSignInAPI({this.testing = 0}) {
    if (testing == 0) {
      _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
    }
    else {
      signedIn = false;
    }
  }

  Future<void> signIn() async {
    if (testing == 0) {
      await _googleSignIn.signIn();
    }
    else if(testing == 1) {
      signedIn = true;
      return;
    }
    else if(testing == 2) {
      throw new Exception();
    }
    else if(testing == 3) {
      signedIn = true;
      return;
    }
  }

  Future<void> disconnect() async {
    if (testing == 0) {
      await _googleSignIn.disconnect();
    } else if (testing == 1) {
      signedIn = false;
      return;
    }
    else if(testing == 2) {
      signedIn = false;
      return;
    }
    else if(testing == 3) {
      throw new Exception();
    }
  }

  Future<bool> isSignedIn() async {
    if(testing == 0) {
      return _googleSignIn.isSignedIn();
    }
    else {
      return signedIn;
    }

  }

  User get currentUser {
    if(testing == 0) {
      return new User(displayName: _googleSignIn.currentUser.displayName, email:  _googleSignIn.currentUser.email, photoUrl: _googleSignIn.currentUser.photoUrl);
    }
    else {
      return new User(displayName: "Osheen Sachdev", email: "osheen@google.com", photoUrl: "someurl.com");
    }
  }
}
