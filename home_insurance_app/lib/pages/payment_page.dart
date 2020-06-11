import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/data/user_home_details.dart';

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
          ', ' +
          address.secondLineOfAddress +
          ', ' +
          address.city +
          ', ' +
          address.state +
          ', ' +
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            TextWidget(leftText: 'Name: ', rightText: 'XYZ'),
            SizedBox(
              height: 20.0,
            ),
            TextWidget(
              leftText: 'Address: ',
              rightText: '$myAddress',
            ),
            SizedBox(
              height: 20.0,
            ),
            TextWidget(
              leftText: 'Selected Policy: ',
              rightText: '$policyName',
            ),
            SizedBox(
              height: 20.0,
            ),
            TextWidget(
              leftText: 'Price: ',
              rightText: 'Rs. $policyAmount',
            ),
            SizedBox(
              height: 20.0,
            ),
            TextWidget(
              leftText: 'Offers Availed: ',
              rightText: '$offers',
            ),
            SizedBox(
              height: 20.0,
            ),
            TextWidget(
              leftText: 'Total Discount: ',
              rightText: 'Rs ${discount * (policyAmount / 100)}',
            ),
            SizedBox(
              height: 20.0,
            ),
            TextWidget(
              leftText: 'Final Price: ',
              rightText:
                  'Rs ${policyAmount - (policyAmount * (discount / 100))}',
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

class TextWidget extends StatelessWidget {
  TextWidget(
      {@required String leftText,
      @required String rightText,
      Color leftColor,
      Color rightColor})
      : _leftText = leftText,
        _rightText = rightText,
        _leftColor = leftColor,
        _rightColor = rightColor;

  final String _leftText;
  final String _rightText;
  final Color _leftColor;
  final Color _rightColor;
  @override
  Widget build(BuildContext context) {
    final double _padding = 18.0;

    return Container(
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(_padding),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _leftText,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: _leftColor ?? Colors.grey[800],
                ),
              ),
              Text(
                _rightText,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: _rightColor ?? Colors.brown[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
