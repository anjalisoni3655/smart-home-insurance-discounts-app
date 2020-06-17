import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:homeinsuranceapp/data/database_utilities.dart';
import 'package:homeinsuranceapp/components/css.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:sdk/sdk.dart';
import 'package:optional/optional.dart';
import 'package:homeinsuranceapp/data/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    String status = await globals.sdk.login();
    if (status == "login successful" || status == "already logged in") {
      Navigator.pushReplacementNamed(
          context, '/home'); // Navigates to the home page

    } else {
      print("Login Failed");
      //TODO Show a snackbar for displaying login failed
    }
  }

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
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Text('Log in to Continue'),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.04,
        ),
        RaisedButton(
          key: Key('navigateToHome'),
          child: Text("LOG IN WITH GOOGLE"),
          color: kLoginButtonColor,
          textColor: kLoginButtonTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          onPressed: () async {
            try {
              final RemoteConfig _remoteConfig = await RemoteConfig.instance;
              await _remoteConfig.fetch();
              await _remoteConfig.activateFetched();

              String _clientId = _remoteConfig.getString('client_id');
              String _clientSecret = _remoteConfig.getString('client_secret');
              String _enterpriseId = _remoteConfig.getString('enterprise_id');
              SDK sdk =
                  SDKBuilder.build(_clientId, _clientSecret, _enterpriseId);
              String status = await sdk.login();

              if (status == "login successful") {
                Optional<Map> userDetailsOptional = await sdk.getUserDetails();
                User user = User();
                user.displayName = userDetailsOptional.value['displayName'];
                user.email = userDetailsOptional.value['email'];
                user.photoUrl = userDetailsOptional.value['photoUrl'];

                final doc = await Firestore.instance.collection('user').where('email', isEqualTo: user.email).getDocuments();

                if (doc.documents.length == 0) {print(' ========= uploading');
                await uploadUserDetails(
                  name: user.displayName,
                  email: user.email,
                  photourl: user.photoUrl,
                );
                }
                  print('No need to upload');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              } else if (status == 'already logged in') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              }
            } catch (e) {
              print(e);
            }
          },
        ),

      ],
    );
  }
}
