import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/database_utilities.dart';

//widget for the my profile page displaying user's details
class Profile extends StatefulWidget {
  static const String id = 'profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name;
  String email;
  String photoUrl;

  void getUserDetails() async {
    name = await localStorage.read(key: 'name');
    email = await localStorage.read(key: 'email');
    photoUrl = await localStorage.read(key: 'photourl');
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
    // print(photoUrl);
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
              //backgroundImage: NetworkImage("https://www.google.com/imgres?imgurl=https%3A%2F%2Fres.cloudinary.com%2Fdtbudl0yx%2Fimage%2Ffetch%2Fw_2000%2Cf_auto%2Cq_auto%2Cc_fit%2Fhttps%3A%2F%2Fadamtheautomator.com%2Fcontent%2Fimages%2Fsize%2Fw2000%2F2019%2F10%2Fuser-1633249_1280.png&imgrefurl=https%3A%2F%2Fadamtheautomator.com%2Fnew-aduser%2F&tbnid=bon71Qy4q_szHM&vet=12ahUKEwiWtOKNqf3pAhWhx3MBHZUACNUQMygCegUIARDVAQ..i&docid=sMaz-t69UtiOWM&w=2000&h=1950&q=user&ved=2ahUKEwiWtOKNqf3pAhWhx3MBHZUACNUQMygCegUIARDVAQ"),
              backgroundColor: Colors.blue,
            ),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Business Analyst',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                color: Colors.black,
                fontSize: 20.0,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
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
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
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
                    email,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontFamily: 'Source Sans Pro'),
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
