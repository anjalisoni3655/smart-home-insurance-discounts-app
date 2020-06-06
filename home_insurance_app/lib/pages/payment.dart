import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homeinsuranceapp/pages/choose_policy.dart';
import 'package:homeinsuranceapp/pages/confirm_payment.dart';
import 'choose_policy.dart';
import 'package:homeinsuranceapp/pages/confirm_payment.dart';


class Payment extends StatefulWidget {
  //Payment({this.discount});
  //final int discount;
  static const id ='payment';

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _firestoreDb = Firestore.instance;

  String userName;

  String policyName;

  int pincode;

  int policyAmount;
  int discount;

  void getData() async
  {
      final rawData = await _firestoreDb.collection('devices').document('user_details').get();
      final data = rawData.data;
      setState(() {
        userName = data['userName'];
        policyName = data['policyName'];
        policyAmount = data['amount'];
        pincode = data['pincode'];
        discount=data['discount'];
      });

  }

  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment details'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.white,
      body:Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text('Name: $userName',textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text('Address:$pincode ',textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),

            Text('Selected Policy: $policyName',textScaleFactor: 1.5,),
            SizedBox(
              height: 20.0,
            ),
            Text('Price: Rs. $policyAmount',textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text('Offers Availed: smart home discount ',textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text('Total Discount:  $discount ',textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text('Final Price: Rs ($policyAmount- $discount)',textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),


          ],



        ),
      ) ,

      floatingActionButton:
          FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, ConfirmPayment.id);
          }, // Goes to the payment page
          backgroundColor: Colors.lightBlueAccent,
          icon: Icon(Icons.payment),
          label: Text(
            'Confirm Payment',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );


  }
}

