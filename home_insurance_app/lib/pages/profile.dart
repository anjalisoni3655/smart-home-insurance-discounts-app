import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/components/css.dart';

//widget for the my profile page displaying user's details
class Profile extends StatelessWidget {
  static const String id = 'profile';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white70,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/user.png'),
            ),
            Text(
              'Mr. XYZ',
              style: kProfileNameStyle,
            ),
            Text(
              'Business Analyst',
              style: kDesignationTextStyle,
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  title: Text(
                    '+91xxxxxxxxxx',
                    style: kNormalTextStyle,
                  ),
                )),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  title: Text(
                    'xyz@email.com',
                    style: kNormalTextStyle,
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
