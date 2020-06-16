import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/database_utilities.dart';
import 'package:homeinsuranceapp/components/css.dart';

//widget for the my profile page displaying user's details
class Profile extends StatefulWidget {
  static const String id = 'profile';
  static const Key nameKey = Key('name_widget_key');

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name;
  String email;
  String photoUrl;

  void getUserDetails() async {
    String _name = await localStorage.read(key: 'name');
    String _email = await localStorage.read(key: 'email');
    String _photoUrl = await localStorage.read(key: 'photourl');
    setState(() {
      name = _name;
      email = _email;
      photoUrl = _photoUrl;
    });
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

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
              backgroundImage: NetworkImage(photoUrl ??
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQI9VCNp1MXFz_NDRV_JJR-ym1EGhvHfit3lfbzfHLMkEBZlJ9T&usqp=CAU'),
            ),
            Center(
              child: Text(
                name ?? '',
                key: Profile.nameKey,
                style: kProfileNameStyle,
              ),
            ),
            Text(
              'Business Analyst',
              style: kDesignationTextStyle,
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: kProfileIconColor,
              ),
            ),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: kProfileIconColor,
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
                    color: kProfileIconColor,
                  ),
                  title: Text(
                    email ?? '',
                    style: kNormalTextStyle,
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
