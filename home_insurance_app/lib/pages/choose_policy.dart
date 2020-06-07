import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/pages/payment.dart';
import 'package:homeinsuranceapp/pages/smart_discounts.dart';

class Mapping {
  Policy user_choice;
  int index;
  Mapping(int index, Policy user_choice) {
    this.index = index;
    this.user_choice = user_choice;
  }
}

class DisplayPolicies extends StatefulWidget {
  @override
  _DisplayPoliciesState createState() => _DisplayPoliciesState();
}

Map data = {};
final _firestoreDb = Firestore.instance;

class _DisplayPoliciesState extends State<DisplayPolicies> {
  @override
  Widget build(BuildContext context) {
    // data stores the policies available for the user as a key-value pair.
    data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Insurance Company '),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, Payment.id);
        }, // Goes to the payment page
        backgroundColor: Colors.lightBlueAccent,
        icon: Icon(Icons.payment),
        label: Text(
          'Payment',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Available Policies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(height: 50.0),
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(SmartDiscounts.id), // Goes to the smart device discounts page
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.lightBlueAccent[100],
                  ),
                  height: 60.0,
                  width: 350.0,
                  child: Center(
                    child: Text('Get Smart Devices Discounts',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
            ),
            SizedBox(height: 20.0),
            RadioGroup(),
          ],
        ),
      ),
    );
  }
}

class RadioGroup extends StatefulWidget {
  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  Policy default_choice = data['policies'][0];
  int default_index = 0;
  List<Mapping> choices = new List<Mapping>();
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < data['policies'].length; i++) {
      choices.add(new Mapping(i, data['policies'][i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: choices
                .map((data) => RadioListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: Text(
                      '\n${data.user_choice.policyName} \nValid for ${data.user_choice.validity} years',
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        child: Icon(
                          Icons.attach_money,
                          color: Colors.blueAccent,
                          size: 20.0,
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: Text('${data.user_choice.cost}'),
                  ),
                ],
              ),
              groupValue: default_index,
              activeColor: Colors.blue[500],
              value: data.index,
              onChanged: (value) async {
                // A radio button gets selected only when groupValue is equal to value of the respective radio button
                setState(() {
                  default_choice = data.user_choice;
                  default_index =
                      value; //To make groupValue equal to value for the radio button .
                });

                // Storing data to the Firestore database
                await _firestoreDb
                    .collection('devices')
                    .document('user_details')
                    .setData(
                  {
                    'amount': default_choice.cost,
                    'policyName': default_choice.policyName,
                    'validity': default_choice.validity
                  },
                  merge: true,
                )
                    .then((value) => print("Document write successful"))
                    .catchError(() {
                  print("Error writing document");
                });
              },
            ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
