import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/components/css.dart';
import 'package:homeinsuranceapp/pages/login_screen.dart';
import 'package:homeinsuranceapp/pages/menubar.dart';
import 'dart:ui';
import 'package:homeinsuranceapp/pages/profile.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:sdk/sdk.dart';
import 'package:sdk/sdk.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;

// widget for the home page, that contains all menu bar options.
class HomePage extends StatefulWidget {
  static const Key popmenuButton = Key('popmenu_button_key');

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  void onClick(String value) async {
    // When user clicks on logOut , global user object calls the logout function
    if (value == 'Logout') {
      String status = await globals.sdk.logout();
      if (status == "logout successful") {
        Navigator.pushNamed(context, LoginScreen.id);
      } else {
        final _snackBar = SnackBar(
          content: Text('Logout Failed'),
          action: SnackBarAction(
              label: 'Retry',
              onPressed: () async {
                onClick('logout');
              }),
        );
        _globalKey.currentState.showSnackBar(_snackBar);
        String status = await globals.sdk.logout();
      }
    } else {
      // user clicks on the profile option in Popup Menu Button
      Navigator.pushNamed(context, Profile.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey =
        GlobalKey<ScaffoldState>(); // Used for testing the drawer

    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenwidth = mediaQuery.size.width;
    return Scaffold(
      key: _globalKey,
      drawer: AppDrawer(), // Sidebar
      appBar: AppBar(
        title: Text('Home Insurance Company'),
        centerTitle: true,
        backgroundColor: kAppbarColor,
        actions: <Widget>[
          PopupMenuButton<String>(
            key: Key("settings"),
            child: Icon(Icons.accessibility),
            onSelected: onClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'My Profile'}.map((String choice) {
                return PopupMenuItem<String>(
                  key: Key(choice),
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
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
                  top: 15.0, left: screenwidth / 16, right: screenwidth / 16),
              //Orientation compatible
              padding: EdgeInsets.all(15.0),
              width: 6 * screenwidth / 7,
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.5),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Align(
                heightFactor: 1.0,
                child: Text(
                  "All your protection under one roof .Take Home Insurance now and secure your future. Don't forget to exlore the exciting discounts available ",
                  style: kHomeScreenTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
