import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:homeinsuranceapp/pages/login_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      initialRoute: LoginScreen.id,
      routes: {

        LoginScreen.id: (context) => LoginScreen(),
        HomePage.id: (context) => HomePage(),


      },
    );
  }
}