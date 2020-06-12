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
  Map purchase;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      purchase = {
        'structure_id': arguments['structure']['id'],
        'address': arguments['userAddress'],
        'policy': arguments['selectedPolicy'],
        'offer': arguments['selectedOffer'],
        'total_discount': arguments['selectedPolicy'].cost * 0.01 * arguments['offer'].discount,
        'discounted_cost':  arguments['selectedPolicy'].cost * (1 - 0.01 * arguments['offer'].discount)
      };
      print(purchase);
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
              rightText: '${purchase['address']}',
            ),
            SizedBox(
              height: 20.0,
            ),
            TextWidget(
              leftText: 'Selected Policy: ',
              rightText: '${purchase['policy'].name}',
            ),
            SizedBox(
              height: 20.0,
            ),
            TextWidget(
              leftText: 'Cost: ',
              rightText: 'Rs. ${purchase['policy'].cost}',
            ),
            SizedBox(
              height: 20.0,
            ),
            TextWidget(
              leftText: 'Offers Availed: ',
              rightText: '${purchase['offer'].requirements}',
            ),
            SizedBox(
              height: 20.0,
            ),
            TextWidget(
              leftText: 'Total Discount: ',
              rightText: 'Rs ${purchase['total_discount']}',
            ),
            SizedBox(
              height: 20.0,
            ),
            TextWidget(
              leftText: 'Discounted Cost: ',
              rightText:
                  'Rs ${purchase['discounted_cost']}',
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
