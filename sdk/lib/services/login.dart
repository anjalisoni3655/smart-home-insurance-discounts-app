import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:optional/optional.dart';

class Login {
  // Time allowed for Http requests or API calls that are independent of user interactions
  final Duration nonInteractiveFlowTimeout;
  // Time allowed for Http requests or API calls that will require some user interaction or interference (input)
  final Duration interactiveFlowTimeout;
  int testing;
  GoogleSignIn _googleSignIn;

  // Dependency Injection (constructor injection of Google Sign In service)
  Login(GoogleSignIn googleSignIn,
      {this.interactiveFlowTimeout = const Duration(minutes: 1),
      this.nonInteractiveFlowTimeout = const Duration(seconds: 1)}) {
    _googleSignIn = googleSignIn;
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

  Future<Optional<Map>> getUserDetails() async {
    try {
      if (!(await _googleSignIn
          .isSignedIn()
          .timeout(nonInteractiveFlowTimeout))) return Optional.empty();
      return Optional.of({
        "displayName": _googleSignIn.currentUser.displayName,
        "email": _googleSignIn.currentUser.email,
        "photoUrl": _googleSignIn.currentUser.photoUrl
      });
    } catch (error) {
      print(error);
      return Optional.empty();
    }
  }

  Future<Optional<bool>> isSignedIn() async {
    try {
      bool result = await _googleSignIn
          .isSignedIn()
          .timeout(nonInteractiveFlowTimeout);
      return Optional.of(result);
    } catch (error) {
      print(error);
      return Optional.empty();
    }

  }
}
