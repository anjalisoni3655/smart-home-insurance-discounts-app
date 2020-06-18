import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

import 'common_widgets.dart';

class Contact extends StatelessWidget {
  static const String id = 'contact';
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CommonAppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(height: screenheight / 40),
          ContactUs(
            cardColor: Colors.white,
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
        ],
      ),
    );
  }
}
