import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/components/css.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;

//widget for the my profile page displaying user's details
class Profile extends StatefulWidget {
  static const String id = 'profile';
  static const Key nameKey = Key('name_widget_key');

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Profile'),
          centerTitle: true,
          backgroundColor: kAppbarColor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(globals.user.photoUrl ??
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQI9VCNp1MXFz_NDRV_JJR-ym1EGhvHfit3lfbzfHLMkEBZlJ9T&usqp=CAU'),
            ),
            Center(
              child: Text(
                '${globals.user.displayName}',
                key: Profile.nameKey,
                style: kProfileNameStyle.copyWith(color: Colors.black),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      width: 1.2,
                      color: Colors.brown[500],
                    )),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      width: 1.2,
                      color: Colors.brown[500],
                    )),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: kProfileIconColor,
                  ),
                  title: Text(
                    globals.user.email ?? '',
                    style: kNormalTextStyle,
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
