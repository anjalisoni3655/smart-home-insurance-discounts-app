import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

class Login {
  // Time allowed for Http requests or API calls that are independent of user interactions
  Duration nonInteractiveFlowTimeout;
  // Time allowed for Http requests or API calls that will require some user interaction or interference (input)
  Duration interactiveFlowTimeout;
  int testing;
  GoogleSignIn _googleSignIn;

  Login._builder(LoginBuilder loginBuilder) {
    this.nonInteractiveFlowTimeout = loginBuilder.nonInteractiveFlowTimeout;
    this.interactiveFlowTimeout = loginBuilder.interactiveFlowTimeout;
    _googleSignIn = loginBuilder._googleSignIn;
  }

  Future<String> login() async {
    // returns status "login successful", "login failed", "already logged in"
    try {
      if (await _googleSignIn.isSignedIn().timeout(nonInteractiveFlowTimeout)) {
        return "already logged in";
      }
      await _googleSignIn.signIn().timeout(interactiveFlowTimeout);
      return "login successful";
    } catch (error) {
      return "login failed";
    }
  }

  Future<String> logout() async {
    // returns status "logout successful", "logout failed", "not logged in"
    try {
      if (await _googleSignIn.isSignedIn().timeout(nonInteractiveFlowTimeout)) {
        await _googleSignIn.signOut().timeout(nonInteractiveFlowTimeout);
        return "logout successful";
      }
      return "not logged in";
    } catch (error) {
      return "logout failed";
    }
  }

  Future<Map> getUserDetails() async {
    try {
      if (!(await _googleSignIn
          .isSignedIn()
          .timeout(nonInteractiveFlowTimeout))) return null;
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

class LoginBuilder {
  Duration interactiveFlowTimeout;
  Duration nonInteractiveFlowTimeout;
  GoogleSignIn _googleSignIn;

  LoginBuilder({this.interactiveFlowTimeout = const Duration(minutes: 1),
    this.nonInteractiveFlowTimeout = const Duration(seconds: 1)}) {
    _googleSignIn = new  GoogleSignIn();
  }

  LoginBuilder.test(GoogleSignIn googleSignIn,
      {this.interactiveFlowTimeout = const Duration(minutes: 1),
        this.nonInteractiveFlowTimeout = const Duration(seconds: 1)}) {
    _googleSignIn = googleSignIn;
  }

  Login build() {
    return new Login._builder(this);
  }
}