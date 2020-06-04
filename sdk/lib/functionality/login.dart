import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

class Login {
  // Time allowed for Http requests or API calls that will require some user interaction or interference (input)
  Duration userInteractiveFlowTimeout;
  // Time allowed for Http requests or API calls that are independent of user interactions
  Duration nonUserInteractiveFlowTimeout;

  int testing;
  GoogleSignIn _googleSignIn;

  Login(
      {this.userInteractiveFlowTimeout = const Duration(minutes: 1),
      this.nonUserInteractiveFlowTimeout = const Duration(seconds: 1)}) {
    _googleSignIn = GoogleSignIn();
  }
  Login.test(
      GoogleSignIn googleSignIn,
      {this.userInteractiveFlowTimeout = const Duration(minutes: 1),
        this.nonUserInteractiveFlowTimeout = const Duration(seconds: 1)}) {
    _googleSignIn = googleSignIn;
  }

  Future<String> login() async {
    // returns status "login successful", "login failed", "already logged in"
    try {
      if (await _googleSignIn
          .isSignedIn()
          .timeout(nonUserInteractiveFlowTimeout)) {
        return "already logged in";
      }
      await _googleSignIn.signIn().timeout(userInteractiveFlowTimeout);
      return "login successful";
    } catch (error) {
      return "login failed";
    }
  }

  Future<String> logout() async {
    // returns status "logout successful", "logout failed", "not logged in"
    try {
      if (!(await _googleSignIn
          .isSignedIn()
          .timeout(nonUserInteractiveFlowTimeout))) {
        return "not logged in";
      }
      await _googleSignIn.signOut().timeout(nonUserInteractiveFlowTimeout);
      return "logout successful";
    } catch (error) {
      return "logout failed";
    }
  }

  Future<Map> getUserDetails() async {
    try {
      if (!(await _googleSignIn.isSignedIn().timeout(nonUserInteractiveFlowTimeout))) return null;
      return {
        "displayName": _googleSignIn.currentUser.displayName,
        "email": _googleSignIn.currentUser.email,
        "photoUrl": _googleSignIn.currentUser.photoUrl
      };
    } catch (error) {
      return null;
    }

  }
}
