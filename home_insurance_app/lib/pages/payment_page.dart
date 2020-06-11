import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/data/user_home_details.dart';
import 'package:homeinsuranceapp/pages/choose_policy.dart';

class Payment extends StatefulWidget {
  static const id = 'payment';

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String userName;

  String policyName;

  String myAddress;
  String offers;
  int policyAmount;
  int discount;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      UserAddress address = arguments['userAddress'];
      myAddress = address.firstLineOfAddress +
          ',' +
          address.secondLineOfAddress +
          ',' +
          address.city +
          ',' +
          address.state +
          ',' +
          address.pincode.toString();
      Offer offer = arguments['selectedOffer'];
      offers = offer.requirements.toString();
      discount = offer.discount;
      Policy policy = arguments['selectedPolicy'];
      policyName = policy.policyName;
      policyAmount = policy.cost;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment details'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text('Name: ANJALI', textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text('Address:$myAddress ', textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Selected Policy: $policyName',
              textScaleFactor: 1.5,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text('Price: Rs. $policyAmount', textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text('Offers Availed: $offers', textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text('Total Discount: Rs ${discount * (policyAmount / 100)} ',
                textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
            Text(
                'Final Price: Rs ${policyAmount - (policyAmount * (discount / 100))}',
                textScaleFactor: 1.5),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Navigator.pushNamed(context, ConfirmPayment.id);
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
