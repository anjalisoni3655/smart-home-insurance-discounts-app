import 'package:flutter/material.dart';

import 'package:homeinsuranceapp/pages/choose_policy.dart';

import 'choose_policy.dart';
import 'package:homeinsuranceapp/pages/home.dart';



class Payment extends StatefulWidget {
  //Payment({this.discount});
  //final int discount;
  static const id ='payment';

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {




  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null)  {


print(8);
print(arguments['selectedPolicy']);
    }

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
            Text('Name: an',textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text('Address:67777 ',textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),

            Text('Selected Policy:saddsa',textScaleFactor: 1.5,),
            SizedBox(
              height: 20.0,
            ),
            Text('Price: Rs. dsdsds',textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text('Offers Availed: smart home discount ',textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text('Total Discount: ss ',textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text('Final Price: Rs (bvb- adsad)',textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),


          ],



        ),
      ) ,

      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: () {
         // Navigator.pushNamed(context, HomePage.id);
          Navigator.of(context).pop();
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
