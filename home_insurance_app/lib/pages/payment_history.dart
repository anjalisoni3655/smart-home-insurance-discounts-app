import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/components/css.dart';
import 'package:homeinsuranceapp/data/purchase.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:homeinsuranceapp/pages/style/custom_widgets.dart';

//widget to show the payments history of a user
class PurchaseHistory extends StatefulWidget {
  static const id = 'purchase_history';
  @override
  _PurchaseHistoryState createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  List<Purchase> _purchaseList = [];

  Future<void> _updatePurchaseList() async {
    final _list = await globals.purchaseDao.getInsurances(globals.user.userId);
    setState(() {
      _purchaseList = _list;
    });
  }

  Widget displayPurchaseList() {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    if (_purchaseList == null || _purchaseList.length == 0) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: screenheight/50, horizontal: screenwidth/30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('No insurance purchased'),
              SizedBox(height: 10),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/gethomedetails');
                },
                color: Colors.lightBlueAccent,
                child: Center(child: Text('Buy Insurance')),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(10.0),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return PurchaseCard(_purchaseList[index]);
          },
          itemCount: _purchaseList.length,
          padding: EdgeInsets.all(5.0),
        ),
      );
    }
  }

  @override
  void initState() {
    globals.purchaseDao.getInsurances(globals.user.userId).then((value) {
      setState(() {
        _purchaseList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Insurances Purchased'),
        centerTitle: true,
        backgroundColor: kAppbarColor,
        actions: [
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () async {
                await _updatePurchaseList();
              }),
        ],
      ),
      body: Container(
        color: Colors.brown[50],
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenwidth / 100, vertical: screenheight / 100),
              child: Text(
                'Purchase History',
                style: CustomTextStyle(fontSize: 30.0),
              ),
            ),
            CustomDivider(height: screenheight / 150, width: screenwidth / 50),
            Container(
              height: screenheight * 0.8,
              child: displayPurchaseList(),
            ),
          ],
        ),
      ),
    );
  }
}

class PurchaseCard extends StatefulWidget {
  Purchase purchase;
  PurchaseCard(this.purchase);
  @override
  _PurchaseCardState createState() => _PurchaseCardState(purchase);
}

class _PurchaseCardState extends State<PurchaseCard> {
  Purchase _purchase;
  bool flag = false;

  _PurchaseCardState(this._purchase);

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.brown[200],
            child: ListTile(
              leading: Icon(Icons.arrow_drop_down_circle,),
              title: Text('${_purchase.policy.policyName}'),
              subtitle: Text('${_purchase.address}'),
              onTap: () {
                setState(() {
                  flag = !flag;
                });
              },
            ),
          ),
          flag ? Container(
            color: Colors.brown[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: screenheight/100, horizontal: screenwidth/30),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Date purchased:',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                              '${_purchase.dateOfPurchase.toDate().toIso8601String().substring(0, 10)}'
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: screenheight/100, horizontal: screenwidth/100),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Address: ',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '${_purchase.address}' ?? '',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: screenheight/100, horizontal: screenwidth/30),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Selected Policy: ',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '${_purchase.policy.policyName}' ?? '',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: screenheight/100, horizontal: screenwidth/30),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Cost: ',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'Rs. ${_purchase.policy.cost}' ?? '',
                          ),
                        ],
                      ),
                    ),
                    _purchase.offer != null
                        ? Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: screenheight/100, horizontal: screenwidth/30),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Offers Availed',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                '${_purchase.offer}' ?? '',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: screenheight/100, horizontal: screenwidth/30),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Discounted Cost',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                'Rs. ${_purchase.discountedCost}' ?? '',
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                        : Container(),
                  ],
                ),
              ],
            ),
          ): Container(),
        ],
      ),
    );
  }
}
