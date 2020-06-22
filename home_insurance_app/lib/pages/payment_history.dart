import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/components/css.dart';
import 'package:homeinsuranceapp/data/purchase.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:homeinsuranceapp/pages/common_widgets.dart';


//widget to show the payments history of a user
class PurchaseHistory extends StatefulWidget {
  static const id = 'purchase_history';
  @override
  _PurchaseHistoryState createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  List<Purchase> _purchaseList = [];
  bool showProgess = false;

  Future<void> _updatePurchaseList() async {
    setState(() {
      showProgess = true;
    });
    final _list = await globals.purchaseDao.getInsurances(globals.user.userId);
    setState(() {
      _purchaseList = _list;
      showProgess = false;
    });
  }

  Widget displayPurchaseList() {
    if ((_purchaseList == null || _purchaseList.length == 0) &&
        showProgess == false) {
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
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
      return ListView.builder(
        itemBuilder: (context, index) {
          return CardCustom(purchase: _purchaseList[index]);
        },
        itemCount: _purchaseList.length,
        padding: EdgeInsets.all(5.0),
      );
    }
  }

  @override
  void initState() {
    setState(() {
      showProgess = true;
    });
    globals.purchaseDao.getInsurances(globals.user.userId).then((value) {
      setState(() {
        _purchaseList = value;
        showProgess = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
                opacity: showProgess ? 0.5 : 1.0, child: displayPurchaseList()),
            showProgess
                ? Center(child: CircularProgressIndicator())
                : Container(),
          ],
        ),
      ),
    );
  }
}

class CardCustom extends StatelessWidget {
  CardCustom({Purchase purchase}) : _purchase = purchase;
  final Purchase _purchase;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              width: 1.2,
              color: Colors.brown[500],
            )),
        elevation: 10.0,
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
                    leftText: 'Date purchased:',
                    rightText:
                        '${_purchase.dateOfPurchase.toDate().toIso8601String().substring(0, 10)}'),
                TextWidget(
                  leftText: 'Address: ',
                  rightText: '${_purchase.address}' ?? '',
                ),
                TextWidget(
                  leftText: 'Selected Policy: ',
                  rightText: '${_purchase.policy.policyName}' ?? '',
                ),
                TextWidget(
                  leftText: 'Cost: ',
                  rightText: 'Rs. ${_purchase.policy.cost}' ?? '',
                ),
                _purchase.offer != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          TextWidget(
                            leftText: 'Offers Availed: ',
                            rightText: '${_purchase.offer.requirements}' ?? '',
                          ),
                          TextWidget(
                            leftText: 'Discounted Cost: ',
                            rightText: 'Rs ${_purchase.discountedCost}' ?? '',
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
