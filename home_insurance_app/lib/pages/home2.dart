import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/components/css.dart';
import 'package:homeinsuranceapp/pages/login_screen.dart';
import 'package:homeinsuranceapp/pages/menubar.dart';
import 'dart:ui';
import 'package:homeinsuranceapp/pages/profile.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:sdk/sdk.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:homeinsuranceapp/pages/style/custom_widgets.dart';

// widget for the home page, that contains all menu bar options.
class HomePage2 extends StatefulWidget {
  static const Key popmenuButton = Key('popmenu_button_key');

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  void onClick(String value) async {
    // When user clicks on logOut , global user object calls the logout function
    if (value == 'Logout') {
      String status = await globals.sdk.logout();
      if (status == "logout successful") {
        Navigator.pushNamed(context, LoginScreen.id);
        //Reinitialise state of sdk on logOut
        await globals.initialise(test: false);
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
    double screenheight = mediaQuery.size.height;
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.brown[50],
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
            margin: EdgeInsets.only(
                top:3*screenheight/5, left: screenwidth / 16, right: screenwidth / 16),
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {},
                  color:Colors.blueGrey[100],
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Container(
                    height: screenheight / 20,
                    width: 13 * screenwidth / 20,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text("Purchase Insurance",
                        textAlign: TextAlign.center,
                        style: CustomTextStyle(
                          fontSize: 20.0,
                        )),
                  ),
                ),
                SizedBox(height: screenheight / 50),
                RaisedButton(
                  onPressed: () {},
                  color:Colors.blueGrey[100],
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Container(
                    height: screenheight / 20,
                    width: 13 * screenwidth / 20,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text("Smart Device Discounts",
                        textAlign: TextAlign.center,
                        style: CustomTextStyle(
                          fontSize: 20.0,
                        )),
                  ),
                ),
                SizedBox(height: screenheight / 50),
                RaisedButton(
                  onPressed: () {},
                   color:Colors.blueGrey[100],
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Container(
                    height: screenheight / 20,
                    width: 13 * screenwidth / 20,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text("Your Insurances",
                        textAlign: TextAlign.center,
                        style: CustomTextStyle(
                          fontSize: 20.0,
                        )),
                  ),
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
