import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:homeinsuranceapp/components/rounded_buttons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:homeinsuranceapp/pages/home.dart';

//GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // GoogleSignInAccount _currentUser;

  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }*/

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
    /* if (_currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(_currentUser.displayName ?? ''),
            subtitle: Text(_currentUser.email ?? ''),
          ),
          RoundedButton(
            title:'LOG OUT',
            colour: Colors.brown,
            onPressed: _handleSignOut,
            //child: Text('SIGN OUT'),
          ),
          RoundedButton(
            title:'EXPLORE',
            colour: Colors.brown,
            onPressed:(){
              Navigator.pushNamed(context, HomePage.id);
            },
            //child: Text('SIGN OUT'),
          )
        ],
      );
    }
    else{*/
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
        Text('Log in to Continue'),
        RoundedButton(
          title: 'LOG IN',
          colour: Colors.brown,
          onPressed: () {
            Navigator.pushNamed(context, HomePage.id);
          },
          //child: Text('SIGN OUT'),
        ),
      ],
    );
    //}
  }

  /* Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn().whenComplete(() {
        Navigator.pushNamed(context, HomePage.id);
      });
    } catch (error) {
      print(error);
    }
  }*/

  /*Future<void> _handleSignOut() async{
    _googleSignIn.disconnect();
  }*/
}
