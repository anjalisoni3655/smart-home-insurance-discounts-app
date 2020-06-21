import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:homeinsuranceapp/pages/login_screen.dart';
import 'package:optional/optional.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> _gotoLoginOrSignup() async {
    Optional<bool> _alreadyLoggedInOptional = await globals.sdk.isSignedIn();
    bool _alreadyLoggedIn = _alreadyLoggedInOptional.value;

    if (_alreadyLoggedIn) {
      // A new googleSignIn instance to silently login the current signedIn user and get the required details
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signInSilently();
      final _currentUser = _googleSignIn.currentUser;

      globals.user.displayName = _currentUser.displayName;
      globals.user.email = _currentUser.email;
      globals.user.photoUrl = _currentUser.photoUrl;

      final doc = await Firestore.instance
          .collection('user')
          .where('email', isEqualTo: globals.user.email)
          .getDocuments();

      globals.user.userId = doc.documents[0].documentID;

      Navigator.of(context).pushNamed('/home');
    } else {
      Navigator.of(context).pushNamed(LoginScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: Container(
        child: FutureBuilder(
          future: _gotoLoginOrSignup(),
          builder: (context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/loading.gif',
                    width: 400,
                    height: 100,
                  ),
                  Text(
                    'Loading',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
