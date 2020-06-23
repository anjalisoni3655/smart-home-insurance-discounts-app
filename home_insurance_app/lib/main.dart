import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:homeinsuranceapp/pages/login_screen.dart';
import 'package:homeinsuranceapp/pages/my_devices.dart';
import 'package:homeinsuranceapp/pages/profile.dart';
import 'package:homeinsuranceapp/pages/contact.dart';
import 'package:homeinsuranceapp/pages/get_home_details.dart';
import 'package:homeinsuranceapp/pages/choose_policy.dart';
import 'package:homeinsuranceapp/pages/show_discounts.dart';
import 'package:homeinsuranceapp/pages/loading.dart';
import 'package:homeinsuranceapp/pages/payment_page.dart';
import 'pages/home.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:homeinsuranceapp/pages/payment_history.dart';

// this is the root of our application
void main({test = false}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await globals.initialise(test: test);

  runApp(MyApp());
}

// MyApp is used to store all routes and takes the user to the page corresponding to initial route ('/)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      initialRoute: '/loading',
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        Profile.id: (context) => Profile(),
        'login': (context) => LoginScreen(),
        '/home': (context) => HomePage(),
        '/myDevices': (context) => MyDevices(),
        '/loading': (context) => Loading(),
        Contact.id: (context) => Contact(),
        '/gethomedetails': (context) => HomeDetails(),
        '/choosepolicy': (context) => DisplayPolicies(),
        '/showdiscounts': (context) => DisplayDiscounts(),
        Payment.id: (context) => Payment(),
        PurchaseHistory.id: (context) => PurchaseHistory(),
      },
    );
  }
}
