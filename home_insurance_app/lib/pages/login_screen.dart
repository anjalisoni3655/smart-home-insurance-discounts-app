import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:homeinsuranceapp/data/database_utilities.dart';
import 'package:homeinsuranceapp/components/css.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:optional/optional.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:firebase_messaging/firebase_messaging.dart';

// widget for login with google
class LoginScreen extends StatefulWidget {
  static const String id = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    _messaging.getToken().then((token) {
      print(token);
    });
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  Future<void> userLogin() async {
    //using global sdk object named user for calling sdk login function
    try {
      await globals.initialise();
      String status = await globals.sdk.login();

      if (status == "login successful") {
        Optional<Map> userDetailsOptional = await globals.sdk.getUserDetails();

        globals.user.displayName = userDetailsOptional.value['displayName'];
        globals.user.email = userDetailsOptional.value['email'];
        globals.user.photoUrl = userDetailsOptional.value['photoUrl'];

        final doc = await Firestore.instance
            .collection('user')
            .where('email', isEqualTo: globals.user.email)
            .getDocuments();

        if (doc.documents.length == 0) {
          globals.user.userId = await uploadUserDetailsGetUID(
            name: globals.user.displayName,
            email: globals.user.email,
          );
        } else {
          globals.user.userId = doc.documents[0].documentID;
        }
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } else if (status == 'already logged in') {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } else {
        final _snackBar = SnackBar(
          content: Text('Login Failed'),
          action: SnackBarAction(
              label: 'Retry',
              onPressed: () async {
                await userLogin();
              }),
        );
        _globalKey.currentState.showSnackBar(_snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      key: _globalKey,
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        title: Center(child: Text('Home Insurance Company')),
        backgroundColor: kAppbarColor,
        automaticallyImplyLeading: false,
      ),
      body: Center(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              'Smart Home Insurance',
              style: kLoginScreenHeading,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.65,
              width: MediaQuery.of(context).size.width * 0.65,
              child: Image.asset(
                'assets/home_insurance.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Get your smart home secured today!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.3,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: RaisedButton(
                key: ValueKey('login'),
                child: Padding(
                  padding: EdgeInsets.all(11.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            'assets/google_icon.png',
                            fit: BoxFit.contain,
                          )),
                      Text("Log In With Google",
                          style: TextStyle(
                            color: Colors.black87,
                          )),
                    ],
                  ),
                ),
                color: Colors.white,
                elevation: 10.0,
                textColor: Colors.white,
                onPressed: () async {
                  await userLogin();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
