import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  static const String id = 'contact';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        backgroundColor: Colors.teal,
        body: ContactUs(
          cardColor: Colors.white,
          textColor: Colors.black,
          logo: AssetImage('assets/HomePage.jpg'),
          email: '%20care@policybazaar.com',
          companyName: 'Home Insurance',
          companyColor: Colors.black,
          phoneNumber: '+917818044311',
          website: 'https://www.policybazaar.com/home-insurance/',
          tagLine: 'Policy Bazaar',
          taglineColor: Colors.black,


        ),
      ),
    );
  }
}