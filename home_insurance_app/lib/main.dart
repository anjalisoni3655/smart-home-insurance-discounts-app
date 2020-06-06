import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/confirm_payment.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:homeinsuranceapp/pages/get_home_details.dart';
import 'package:homeinsuranceapp/pages/choose_policy.dart';
import 'package:homeinsuranceapp/pages/payment.dart';
import 'package:homeinsuranceapp/pages/confirm_payment.dart';
import 'package:homeinsuranceapp/pages/smart_discounts.dart';
void main() {
  runApp(MyApp());
}

// This class is used to store all routes and taked the user to the page corresponding to initial route ('/)
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/gethomedetails': (context) => HomeDetails(),
        '/choosepolicy': (context) => DisplayPolicies(),
        Payment.id:(context)=>Payment(),
        ConfirmPayment.id:(context)=>ConfirmPayment(),
        SmartDiscounts.id : (context) => SmartDiscounts(),

      },
    );
  }
}
