import 'package:flutter/material.dart';

import 'package:homeinsuranceapp/pages/contact.dart';
import 'package:homeinsuranceapp/pages/payment_history.dart';

// widget for the different options in the menu bar
class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: null,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/HomePage.jpg"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
              key: Key('Purchase Policy'),
              leading: Icon(Icons.home),
              title: Text('Purchase Policy'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/gethomedetails');
              }),
          ListTile(
              key: Key("Smart Devices Discounts"),
              leading: Icon(Icons.money_off),
              title: Text('Smart Devices Discounts'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/showdiscounts',
                    arguments: {'onlyShow': true});
              }),
          ListTile(
              leading: Icon(Icons.devices),
              title: Text('My Devices'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/myDevices');
              }),
          ListTile(
              key: Key('Contact Us'),
              leading: Icon(Icons.phone),
              title: Text('Contact Us'),
              onTap: () {
                // First pop is to pop the menu bar
                Navigator.of(context).pop();
                Navigator.pushNamed(context, Contact.id);
              }),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Insurances Purchased'),
            onTap: () {
              Navigator.pushNamed(context, PurchaseHistory.id);
            },
          ),
        ],
      ),
    );
  }
}
