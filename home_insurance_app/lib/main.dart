import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:homeinsuranceapp/pages/get_home_details.dart';
import 'package:homeinsuranceapp/pages/choose_policy.dart';
void main()  {
  runApp(MyApp());
}

// This class is used to store all routes and taked the user to the page corresponding to initial route ('/)
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        '/':(context)=>HomePage(),
        '/gethomedetails':(context)=>HomeDetails(),
        '/choosepolicy':(context)=>DisplayPolicies(),
      },
    );
  }
}
