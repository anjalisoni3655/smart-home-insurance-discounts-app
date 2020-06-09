import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/components/rounded_buttons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:homeinsuranceapp/pages/home.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          //height: MediaQuery.of(context).size.height,
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Text('Log in to Continue'),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.04,
        ),
        RoundedButton(
          key: Key('navigateToHome'),
          title: 'LOG IN',
          colour: Colors.brown,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
            //TODO: import sdk library to use the google login function
          },
          //child: Text('SIGN OUT'),
        ),
      ],
    );
  }
}