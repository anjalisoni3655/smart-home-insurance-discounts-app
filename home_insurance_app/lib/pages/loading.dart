import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';
import 'package:optional/optional.dart';
import 'package:sdk/sdk.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // Remove this and call sdk isSignedIn
  Future<Optional<bool>> isSignedIn() async {
    await Future.delayed(new Duration(seconds: 4));
    return Optional.of(true);
  }

  @override
  void initState() {
    super.initState();
    SDK sdk = SDKBuilder.build('clientId', 'clientSecret', 'enterpriseId');
    isSignedIn().then((value) {
      if (value.isEmpty || value.value == false) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
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
