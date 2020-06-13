import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';
import 'package:homeinsuranceapp/pages/menubar.dart';
import 'dart:ui';
import 'package:homeinsuranceapp/pages/login_screen.dart';
import 'package:homeinsuranceapp/pages/profile.dart';
import 'dart:convert';
import 'package:sdk/sdk.dart';

// widget for the home page, that contains all menu bar options.
class HomePage extends StatefulWidget {
  static const String id = 'home_screen';
  static const Key popmenuButton = Key('popmenu_key');

  @override
  _HomePageState createState() => _HomePageState();
}

final scaffoldKey = GlobalKey<ScaffoldState>(); // Used for testing the drawer

class _HomePageState extends State<HomePage> {
  void onClick(String value) async {
    if (value == 'Logout') {
      Navigator.pop(context, LoginScreen.id);
//      var credentials = jsonDecode(
//          await DefaultAssetBundle.of(context).loadString(
//              "lib/credentials/akashag-step-interns-test.json")
//      );
//      SDK sdk = SDKBuilder.build(
//          credentials["installed"]["client_id"],
//          credentials["installed"]["client_secret"],
//          "akashag-step-interns-test");
//      String status = await sdk.logout();
//      if (status == "logout successful") {
//        Navigator.pop(context, LoginScreen.id);
//      }
    } else {
      Navigator.pushNamed(context, Profile.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenwidth = mediaQuery.size.width;
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(), // Sidebar
      appBar: AppBar(
        title: Text('Home Insurance Company'),
        centerTitle: true,
        backgroundColor: Colors.brown,
        actions: <Widget>[
          PopupMenuButton<String>(
            child: Icon(Icons.accessibility),
            onSelected: onClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'My Profile'}.map((String choice) {
                return PopupMenuItem<String>(
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
              //Orientation compactible
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
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
