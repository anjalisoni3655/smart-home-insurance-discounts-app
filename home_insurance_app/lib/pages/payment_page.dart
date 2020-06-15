import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/database_utils.dart';
import 'package:homeinsuranceapp/pages/home.dart';

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
      double totalDiscount = getFinalDiscount(
          cost: arguments['selectedPolicy'].cost,
          discount: arguments['selectedOffer'].discount);
      double totalAmount = getFinalAmount(
          cost: arguments['selectedPolicy'].cost,
          discount: arguments['selectedOffer'].discount);
      purchase = {
//        'structure_id': arguments['structure']['id'],
        'address': arguments['userAddress'],
        'policy': arguments['selectedPolicy'],
        'offer': arguments['selectedOffer'],
        'total_discount': totalDiscount,
        'discounted_cost': totalAmount,
      };
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment details'),
        centerTitle: true,
        backgroundColor: Colors.brown,
        //TODO :extract this layout details to separate css.dart file
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextWidget(
                  key: Key('name'), leftText: 'Name: ', rightText: 'XYZ'),
              SizedBox(
                height: 20.0,
              ),
              TextWidget(
                leftText: 'Address: ',
                rightText: '${purchase['address']}' ?? '',
              ),
              SizedBox(
                height: 20.0,
              ),
              TextWidget(
                leftText: 'Selected Policy: ',
                rightText: '${purchase['policy'].policyName}' ?? '',
              ),
              SizedBox(
                height: 20.0,
              ),
              TextWidget(
                leftText: 'Cost: ',
                rightText: 'Rs. ${purchase['policy'].cost}' ?? '',
              ),
              SizedBox(
                height: 20.0,
              ),
              TextWidget(
                leftText: 'Offers Availed: ',
                rightText: '${purchase['offer'].requirements}' ?? '',
              ),
              SizedBox(
                height: 20.0,
              ),
              TextWidget(
                leftText: 'Total Discount: ',
                rightText: 'Rs ${purchase['total_discount']}' ?? '',
              ),
              SizedBox(
                height: 20.0,
              ),
              TextWidget(
                leftText: 'Discounted Cost: ',
                rightText: 'Rs ${purchase['discounted_cost']}' ?? '',
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(HomePage.id);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.payment,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Confirm Payment',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15.0),
                      color: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                  SizedBox(width: 20),
                  RaisedButton(
                      onPressed: () {
                        addInsurancePurchased(purchase);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.cancel,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Cancel Payment',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15.0),
                      color: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  TextWidget(
      {Key key,
      @required String leftText,
      @required String rightText,
      Color leftColor,
      Color rightColor})
      : _leftText = leftText,
        _rightText = rightText,
        _leftColor = leftColor,
        _rightColor = rightColor,
        super(key: key);

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
