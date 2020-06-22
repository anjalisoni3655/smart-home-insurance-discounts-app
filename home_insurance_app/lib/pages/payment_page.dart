import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/purchase.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:homeinsuranceapp/data/offer_service.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';
import 'package:homeinsuranceapp/pages/style/custom_widgets.dart';

class Payment extends StatefulWidget {
  static const id = 'payment';

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Purchase purchase;
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
      purchase = new Purchase(
          arguments['selectedPolicy'],
          arguments['selectedOffer'],
          arguments['structureId'],
          Timestamp.now(),
          arguments['userAddress']);
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
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenwidth / 100, vertical: screenheight / 100),
              child: Text(
                'Payment',
                style: CustomTextStyle(fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
            CustomDivider(height: screenheight / 150, width: screenwidth / 50),
            SizedBox(height: screenheight/20),
            Container(
              height: screenheight * 0.6,
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: screenheight/150, horizontal: screenwidth/20),
                    color: Colors.brown[50],
                    child: ListTile(
                        title: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        subtitle: Text(
                          '${globals.user.displayName}' ?? '',
                          key: Key('name'),
                          style: TextStyle(
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.left,
                        ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: screenheight/150, horizontal: screenwidth/20),
                    color: Colors.brown[50],
                    child: ListTile(
                      title: Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle:  Text(
                        '${purchase.address}' ?? '',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: screenheight/150, horizontal: screenwidth/20),
                    color: Colors.brown[50],
                    child: ListTile(
                      title: Text(
                          'Selected Policy',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle:  Text(
                        '${purchase.policy.policyName}' ?? '',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: screenheight/150, horizontal: screenwidth/20),
                    color: Colors.brown[50],
                    child: ListTile(
                      title: Text(
                          'Cost',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle:  Text(
                        'Rs. ${purchase.policy.cost}' ?? '',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  // The discount and offer received by tFhe user will only be shown when user has selected one .
                  arguments['selectedOffer'] != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: screenheight/150, horizontal: screenwidth/20),
                              color: Colors.brown[50],
                              child: ListTile(
                                title: Text(
                                  'Offer Availed',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                subtitle:  Text(
                                  '${purchase.offer}' ?? '',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: screenheight/150, horizontal: screenwidth/20),
                              color: Colors.brown[50],
                              child: ListTile(
                                title: Text(
                                  'Discounted Cost',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                subtitle:  Text(
                                  '${purchase.discountedCost}' ?? '',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: screenwidth/30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                        key: Key('Cancel Payment'),
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
                    RaisedButton(
                        key: Key('Confirm Payment'),
                        onPressed: () {
                          print('insurance purchased');
                          print(purchase.toString());
                          globals.purchaseDao
                              .addPurchase(globals.user.userId, purchase);
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
