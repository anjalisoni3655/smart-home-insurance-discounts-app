import 'dart:async';
import 'package:sdk/mock_api/google_sign_in_api.dart';

class Login {
  // Time allowed for Http requests or API calls that will require some user interaction or interference (input)
  Duration userInteractiveFlowTimeout;
  // Time allowed for Http requests or API calls that are independent of user interactions
  Duration nonUserInteractiveFlowTimeout;

  int testing;
  GoogleSignInAPI googleSignInAPI;

  Login(
      {this.testing = 0,
      this.userInteractiveFlowTimeout = const Duration(minutes: 1),
      this.nonUserInteractiveFlowTimeout = const Duration(seconds: 1)}) {
    googleSignInAPI = GoogleSignInAPI(testing: testing);
  }

  Future<String> login() async {
    // returns status "login successful", "login failed", "already logged in"
    try {
      if (await googleSignInAPI
          .isSignedIn()
          .timeout(nonUserInteractiveFlowTimeout)) {
        return "already logged in";
      }
      await googleSignInAPI.signIn().timeout(userInteractiveFlowTimeout);
      return "login successful";
    } catch (error) {
      return "login failed";
    }
  }

  Future<String> logout() async {
    // returns status "logout successful", "logout failed", "not logged in"
    try {
      if (!(await googleSignInAPI
          .isSignedIn()
          .timeout(nonUserInteractiveFlowTimeout))) {
        return "not logged in";
      }
      await googleSignInAPI.disconnect().timeout(nonUserInteractiveFlowTimeout);
      return "logout successful";
    } catch (error) {
      return "logout failed";
    }
  }

  Future<Map> getUserDetails() async {
    try {
      if (!(await googleSignInAPI.isSignedIn().timeout(nonUserInteractiveFlowTimeout))) return null;
      return googleSignInAPI.currentUser;
    } catch (error) {
      return null;
    }

  }
}
