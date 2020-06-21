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
    print('future started');
    Optional<bool> _alreadyLoggedInOptional = await globals.sdk.isSignedIn();
    bool _alreadyLoggedIn = _alreadyLoggedInOptional.value;
    print('already logged in : $_alreadyLoggedIn');
    if (_alreadyLoggedIn) {
      print('already logged in functionality started');
      //  final _googleSignIn = GoogleSignIn();
      //  final signedin = _googleSignIn.currentUser;
      //  print(signedin.toString());
      // print(_googleSignIn.currentUser.displayName);
      Optional<Map> userDetailsOptional = await globals.sdk.getUserDetails();
      print(userDetailsOptional.value.toString());
      globals.user.displayName = userDetailsOptional.value['displayName'];
      globals.user.email = userDetailsOptional.value['email'];
      globals.user.photoUrl = userDetailsOptional.value['photoUrl'];

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
