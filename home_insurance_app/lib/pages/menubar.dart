import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/contact.dart';
import 'package:url_launcher/url_launcher.dart';

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
            // child: Center('Smart Home',textScaleFactor: 3.0,)),

            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/HomePage.jpg"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Purchase Policy'),
              onTap: () {
                Navigator.of(context).pop();
              }),
          ListTile(
              leading: Icon(Icons.money_off),
              title: Text('Smart Devices Discounts'),
              onTap: () {
                Navigator.of(context).pop();
              }),
          ListTile(
              leading: Icon(Icons.devices),
              title: Text('My Devices'),
              onTap: () {
                launch("https://nestservices.google.com/partnerconnections");
              }),
          ListTile(
              leading: Icon(Icons.phone),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pushNamed(context, Contact.id);
              }),
          ListTile(
              leading: Icon(Icons.perm_device_information),
              title: Text('Disable access'),
              onTap: () {
                launch("https://myaccount.google.com/permissions");
              }),
        ],
      ),
    );
  }
}
