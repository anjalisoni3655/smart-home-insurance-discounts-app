import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:homeinsuranceapp/pages/login_screen.dart';
import 'package:homeinsuranceapp/pages/my_devices.dart';
import 'package:homeinsuranceapp/pages/profile.dart';
import 'package:homeinsuranceapp/pages/contact.dart';
import 'package:homeinsuranceapp/pages/get_home_details.dart';
import 'package:homeinsuranceapp/pages/get_home_details.dart';
import 'package:homeinsuranceapp/pages/choose_policy.dart';
import 'package:homeinsuranceapp/pages/show_discounts.dart';
import 'pages/home.dart';


// this is the root of our application
void main() {
  runApp(MyApp());
}

// MyApp is used to store all routes and takes the user to the page corresponding to initial route ('/)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomePage.id: (context) => HomePage(),
        Profile.id: (context) => Profile(),
        MyDevices.id: (context) => MyDevices(),
        Contact.id: (context) => Contact(),
        '/': (context) => HomePage(),
        '/gethomedetails': (context) => HomeDetails(),
        '/choosepolicy': (context) => DisplayPolicies(),
        '/showdiscounts': (context) => DisplayDiscounts(),
      },
    );
  }
}
