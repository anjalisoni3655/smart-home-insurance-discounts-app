import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:homeinsuranceapp/pages/my_devices.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/mydevices': (context) => MyDevices(),
      },
    );
  }
}
