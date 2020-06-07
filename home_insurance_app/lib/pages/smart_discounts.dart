import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/payment.dart';

class SmartDiscounts extends StatefulWidget {
  static const id = 'smart_discounts';
  // final _firestoreDb = Firestore().instance;
  static const double dis =
      0.01 * (4) * 4000 + 0.02 * (1) * 4000 + 0.03 * (3) * 4000;

  @override
  _SmartDiscountsState createState() => _SmartDiscountsState();
}

class _SmartDiscountsState extends State<SmartDiscounts> {
  final _firestoreDb = Firestore.instance;

  int noOfThermostat = 4;

  int noOfSmoke = 1;

  int noOfFireAlarm = 3;

  int discount = SmartDiscounts.dis.toInt();

  void getDevices() {
    //TODO Get devices and their info from the api
  }

  void uploadDb() async {
    //TODO Upload the device details to the database
    await _firestoreDb
        .collection('devices')
        .document('user_details')
        .setData(
          {
            'noOfThermostat': noOfThermostat,
            'noOfSmoke': noOfSmoke,
            'noOfFireAlarm': noOfFireAlarm,
            'discount': discount,
          },
          merge: true,
        )
        .then((value) => print("Document write successful"))
        .catchError(() {
          print("Error writing document");
        });
  }

  @override
  void initState() {
    uploadDb();
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print("Uploading done");
    return Scaffold(
      appBar: AppBar(
       title: Text("Home Insurance App"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text(
                "Smart Home Discounts",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Text("What is smart home discount?"),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text("Thermostat"),
                          subtitle: Text("1%"),
                          trailing: Text('$noOfThermostat'),
                        ),
                        ListTile(
                          title: Text("FireAlarm"),
                          subtitle: Text("2%"),
                          trailing: Text('$noOfFireAlarm'),
                        ),
                        SizedBox(height: 20),
                        ListTile(
                          title: Text("Smoke Detector"),
                          subtitle: Text("3%"),
                          trailing: Text('$noOfSmoke'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                //flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Center(
                          child: Text("Link Devices"),
                        ),
                      ),
                      ListTile(
                        title: Center(
                          child: Text("My Linked Devices"),
                        ),
                      ),
                      ListTile(
                        title: Center(
                          child: Text("Proceed To Payment"),

                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(Payment.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
