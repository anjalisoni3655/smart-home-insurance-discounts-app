import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/insurance_dao.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:homeinsuranceapp/data/offer_service.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';

class Payment extends StatefulWidget {
  static const id = 'payment';

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Map purchase;
  String userName = "";

  @override
  void initState() {
    // Before page is displayed , user name is retrieved from sdk .
    super.initState();
    //While testing sdk is not initialised , so username is returned as empty string
    if (globals.sdk != null) {
      getUserName().then((name) {
        setState(() {
          userName = name;
        });
      });
    } else
      userName = "";
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      int discount = (arguments['selectedOffer'] != null)
          ? arguments['selectedOffer'].discount
          : 0;
      purchase = {
//      'structure_id': arguments['structure']['id'],
        'address': arguments['userAddress'],
        'policy': arguments['selectedPolicy'],
        'offer': arguments['selectedOffer'],
        'total_discount': arguments['selectedPolicy'].cost * 0.01 * discount,
        'discounted_cost':
            arguments['selectedPolicy'].cost * (1 - 0.01 * discount),
      };
    }

    return Scaffold(
      appBar: CommonAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TextWidget(
                    //TODO Get the name from the user details from sdk
                    key: Key('name'),
                    leftText: 'Name: ',
                    rightText: userName),
                TextWidget(
                  leftText: 'Address: ',
                  rightText: '${purchase['address']}' ?? '',
                ),
                TextWidget(
                  leftText: 'Selected Policy: ',
                  rightText: '${purchase['policy'].policyName}' ?? '',
                ),

                TextWidget(
                  leftText: 'Cost: ',
                  rightText: 'Rs. ${purchase['policy'].cost}' ?? '',
                ),

                // The discount and offer received by the user will only be shown when user has selected one .
                arguments['selectedOffer'] != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          TextWidget(
                            leftText: 'Offers Availed: ',
                            rightText:
                                '${purchase['offer'].requirements}' ?? '',
                          ),
                          TextWidget(
                            leftText: 'Total Discount: ',
                            rightText: 'Rs ${purchase['total_discount']}' ?? '',
                          ),
                          TextWidget(
                            leftText: 'Discounted Cost: ',
                            rightText:
                                'Rs ${purchase['discounted_cost']}' ?? '',
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                              SizedBox(width: screenwidth / 200),
                              Text(
                                'Cancel Payment',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(0.0),
                          color: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                          onPressed: () {
                            addInsurancePurchased(purchase);
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.payment,
                                color: Colors.white,
                              ),
                              SizedBox(width: screenwidth / 200),
                              Text(
                                'Confirm Payment',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(screenwidth / 100),
                          color: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
