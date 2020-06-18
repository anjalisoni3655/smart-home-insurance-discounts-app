import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:homeinsuranceapp/components/css.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:sdk/sdk.dart';
import 'dart:convert';
import 'package:homeinsuranceapp/data/globals.dart' as globals;

// widget for login with google
class LoginScreen extends StatefulWidget {
  static const String id = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  Future<void> userLogin() async {
    //using global sdk object named user for calling sdk login function
    globals.user = await globals.initialiseSDK();
    String status = await globals.user.login();
    if (status == "login successful" || status == "already logged in") {
      Navigator.pushNamed(context, '/home'); // Navigates to the home page
    } else {
      print("Login Failed");
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
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      key: _globalKey,
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        title: Center(child: Text('Smart Home')),
        backgroundColor: kAppbarColor,
      ),
      body: Center(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        TypewriterAnimatedTextKit(
          text: ['Smart Home'],
          textStyle: kLoginScreenHeading,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Text('Log in to Continue'),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.04,
        ),
        RaisedButton(
            key: Key('navigateToHome'),
            child: Text("LOG IN WITH GOOGLE"),
            color: Colors.brown,
            textColor: Colors.white,
            onPressed: () async {
              await userLogin();
            },
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))),
      ],
    );
  }
}
