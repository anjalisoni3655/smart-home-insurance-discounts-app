import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/components/rounded_buttons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:homeinsuranceapp/pages/home.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
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
          height: MediaQuery.of(context).size.height,
        ),

        Text('Log in to Continue'),
        SizedBox(
          height: MediaQuery.of(context).size.height,,
        ),
        RoundedButton(
          title: 'LOG IN',
          colour: Colors.brown,
          onPressed: () {
            Navigator.pushNamed(context, HomePage.id);
            //TODO: import sdk library to use the google login function
          },
          //child: Text('SIGN OUT'),
        ),
      ],
    );
  }
}
