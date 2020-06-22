import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/components/css.dart';

class Contact extends StatelessWidget {
  static const String id = 'contact';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contact Us'),
          centerTitle: true,
          backgroundColor: kAppbarColor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        backgroundColor: new Color(0xFFFFFFFF),
        body: ContactUs(
          cardColor: Colors.lightBlueAccent,
          textColor: Colors.black,
          logo: AssetImage('assets/HomePage.jpg'),
          email: 'abdcfff@email.com',
          companyName: 'Home Insurance',
          companyColor: Colors.black,
          phoneNumber: '+91xxxxxxxxxxx',
          website: 'https://nest.com/',
          tagLine: 'Smart Home,Safe Home',
          taglineColor: Colors.black,
        ),
      ),
    );
  }
}
