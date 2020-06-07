import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis_auth/auth_io.dart';
// import 'package:homeinsuranceapp/components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:homeinsuranceapp/constants.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
// Class id = new Class();

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  GoogleSignInAccount _currentUser;
  final Firestore _firestoreDb = Firestore.instance;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Home'),
      ),
      body: Center(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_currentUser != null) {
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
          RaisedButton(
            onPressed: () async {
              await _handleSignOut();
            },
            color: Colors.lightBlueAccent,
            child: Text("Log Out"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              await auth();
            },
            color: Colors.lightBlueAccent,
            child: Text("Log Out"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      );
    } else {
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
            height: 24.0,
          ),
          Text('You are not logged in..'),
          SizedBox(
            height: 24.0,
          ),
          RaisedButton(
            onPressed: () async {
              await _handleSignIn();
              //Navigator.of
            },
            color: Colors.lightBlueAccent,
            child: Text("Log In"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      );
    }
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

  Future<void> auth() async {
    String _clientId = '';
    String _clientSecret = '';
    String _url = '';
    String _url2 = '';
    List<String> _scopes = [];
    Uri.parse(_url);

    var authClient = await clientViaUserConsent(ClientId(_clientId, _clientSecret), _scopes, (url) {
      launch(url);
    });

    String a = authClient.credentials.accessToken.data;
    print("Access Token");
    print(a);

    final client = new http.Client();
    final response = await client.post(
      _url2,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $a'},
    );
    final responseJson = json.decode(response.body);

    await _firestoreDb
        .collection('devices')
        .document('user_details')
        .setData({
          'jsonResponse': responseJson,
        }, merge: true)
        .then((value) => print("Data written successfully"))
        .catchError(() {
          print("Error writing document");
        });

    print(responseJson['error']);
  }
}
