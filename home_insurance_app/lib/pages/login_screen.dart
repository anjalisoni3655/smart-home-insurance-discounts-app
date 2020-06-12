import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:sdk/sdk.dart';

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
        RaisedButton(
            key: Key('navigateToHome'),
            child: Text("LOG IN WITH GOOGLE"),
            color: Colors.brown,
            textColor: Colors.white,
            onPressed: () async {

              try {
                final RemoteConfig _remoteConfig = await RemoteConfig.instance;
                await _remoteConfig.fetch();
                await _remoteConfig.activateFetched();
                String _projectId = _remoteConfig.getString('project_id');
                String _clientId = _remoteConfig.getString('client_id');
                String _clientSecret = _remoteConfig.getString('client_secret');
                String _enterpriseId = _remoteConfig.getString('enterprise_id');
                SDK sdk = SDKBuilder.build(_projectId, _clientId, _clientSecret, _enterpriseId);
//              String status = await sdk.login();
              String status = await sdk.requestDeviceAccess();
              print(status);
              if(status == 'authorization successful') {
                print(await sdk.getAllDevices());
              }
              } catch (e) {
                print(e);
                print('Error retrieving data from RemoteConfig');
              }
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
