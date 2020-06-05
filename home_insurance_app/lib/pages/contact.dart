import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  static const String id = 'contact';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: new Color(0xFFE57373),
        body: ContactUs(
          cardColor: Colors.white,
          textColor: Colors.black,
          logo: AssetImage('assets/HomePage.jpg'),
          email: 'anjalisoni3655@gmail.com',
          companyName: 'Home Insurance',
          companyColor: Colors.black,
          phoneNumber: '+916203402847',
          website: 'https://nest.com/',
          tagLine: 'Smart Home, Safe Home',
          taglineColor: Colors.black,
        ),
      ),
    );
  }
}
