import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdk/User.dart';


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
    else if(testing == 4) {
      await Future.delayed(const Duration(milliseconds: 200));
      signedIn = true;
      return;
    }
    else if(testing == 5) {
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
    else if(testing == 4) {
      await Future.delayed(const Duration(milliseconds: 200));
      signedIn = false;
      return;
    }
    else if(testing == 5) {
      signedIn = false;
      return;
    }
  }

  Future<bool> isSignedIn() async {
    if(testing == 0) {
      return _googleSignIn.isSignedIn();
    }
    else if(testing == 5) {
      await Future.delayed(new Duration(milliseconds: 200));
      return signedIn;
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
