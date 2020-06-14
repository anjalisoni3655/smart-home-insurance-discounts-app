import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
  Future<void> userLogin() async {
    //using global sdk object named user for calling sdk login function
    globals.user = await globals.con();
    String status = await globals.user.login();
    if (status == "login successful") {
      print(status);
      Navigator.pushNamed(context, '/home'); // Navigates to the home page
    } else if (status == "already logged in") {
      print(status);
      Navigator.pushNamed(context, '/home');
    } else {
      print("Login Failed");
      //TODO Show a snackbar for displaying login failed
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Smart Home')),
        backgroundColor: Colors.brown,
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
          textStyle: TextStyle(
            fontSize: 45.0,
            fontWeight: FontWeight.w900,
          ),
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
