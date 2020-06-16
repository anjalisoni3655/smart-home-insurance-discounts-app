import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:homeinsuranceapp/data/database_utilities.dart';
import 'package:homeinsuranceapp/components/css.dart';
import 'package:homeinsuranceapp/pages/home.dart';

// widget for login with google
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
          //height: MediaQuery.of(context).size.height,
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
//TODO: import sdk library to use the google login function
            },
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)))
      ],
    );
  }
}
