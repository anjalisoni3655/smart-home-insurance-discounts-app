import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:optional/optional.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

void updateUserDetails(BuildContext context) async {
//   print('started');
//   await globals.initialise();
//   Optional<Map> userDetailsOptional = await globals.sdk.getUserDetails();
//   globals.user.displayName = userDetailsOptional.value['displayName'];
//   globals.user.email = userDetailsOptional.value['email'];
//   globals.user.photoUrl = userDetailsOptional.value['photoUrl'];
//   print('gotr details');
//   final doc = await Firestore.instance
//       .collection('user')
//       .where('email', isEqualTo: globals.user.email)
//       .getDocuments();
// print('got docs');
//   final id = doc.documents[0].documentID;
//   print('user id ${globals.user.userId}');
//   globals.user.userId = id;
//   print('user id ${globals.user.userId}');
  Navigator.pushReplacementNamed(context, '/home');
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    globals.sdk.isSignedIn().then((value) {
      if (value.isEmpty || value.value == false) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        updateUserDetails(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/loading.gif',
                width: 400,
                height: 100,
              ),
              Text(
                'Loading',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
