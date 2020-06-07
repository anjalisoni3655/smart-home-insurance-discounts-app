import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/menubar.dart';
import 'dart:ui';
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
// import 'package:homeinsu

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Firestore _firestoreDb = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenwidth = mediaQuery.size.width;
    return Scaffold(
      drawer: AppDrawer(), // Sidebar
      appBar: AppBar(
        title: Text('Home Insurance Company'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Stack(
        children: <Widget>[
          //RaisedButton
          Container(
            // Container will contain a blur background image
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/HomePage.jpg'),
              fit: BoxFit.cover,
            )),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2.0,
                sigmaY: 2.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  //BoxDecoration required for setting the opacity why ?
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ),
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: 15.0,
                  left: screenwidth / 16,
                  right: screenwidth / 16), //Orientation compactible
              padding: EdgeInsets.all(15.0),
              width: 6 * screenwidth / 7,
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.5),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Align(
                heightFactor: 1.0,
                child: Column(
                  children: <Widget>[

                    Text(
                        "All your protection under one roof .Take Home Insurance now and secure your future. Don't forget to exlore the exciting discounts available ",
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        )),
                    RaisedButton(
                      child: Text("click here"),
                      onPressed: auth,
                    ),
                  ],
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
  Future<void> auth() async {
    String _clientId = '482460250779-8mk7lco5njbim010jimu5u1c39iisod7.apps.googleusercontent.com';
    String _clientSecret = '-RSvp0BZvHjc6Pk05I_DpFeO';
    String _url = 'https://accounts.google.com/o/oauth2/auth?client_id=482460250779-8mk7lco5njbim010jimu5u1c39iisod7.apps.googleusercontent.com&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsdm.service&state=state';
    String _url2 = 'https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/akashag-step-interns-test/structures';
    List<String> _scopes = ['https://www.googleapis.com/auth/sdm.service'];
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
    final responseJson = await json.decode(response.body);
    //print(responseJson);

    await _firestoreDb
        .collection('devices')
        .document('user_details')
        .setData({
      'jsonResponse': responseJson,
    },)
        .then((value) => print("Data written successfully"))
        .catchError(() {
      print("Error writing document");
    });

    print(responseJson['error']);
  }
}
