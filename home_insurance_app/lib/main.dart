import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:homeinsuranceapp/pages/login_screen.dart';
import 'package:homeinsuranceapp/pages/get_home_details.dart';
import 'package:homeinsuranceapp/pages/choose_policy.dart';
import 'package:homeinsuranceapp/pages/show_discounts.dart';

void main() {
  runApp(MyApp());
}


// This class is used to store all routes and taked the user to the page corresponding to initial route ('/)
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
    initialRoute: '/login',
    routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginScreen(),
        '/gethomedetails': (context) => HomeDetails(),
        '/choosepolicy': (context) => DisplayPolicies(),
        '/showdiscounts': (context) => DisplayDiscounts(),
      },
    );
  }
}
