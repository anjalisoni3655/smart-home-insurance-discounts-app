import 'package:flutter/material.dart';
import 'package:flutter_rave/flutter_rave.dart';

class ConfirmPayment extends StatefulWidget {
  static const id = 'confirm_payment';
  ConfirmPayment({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ConfirmPaymentState createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('payment'),
        centerTitle: true,
      ),
      body: Center(
        child: Builder(
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: InkWell(
                onTap: () => _pay(context),
                child: Card(
                  color: Colors.orangeAccent,
                  elevation: 15,
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Card Payment",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.payment,
                            color: Colors.black,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _pay(BuildContext context) {
    final snackBar_onFailure = SnackBar(content: Text('Transaction failed'));
    final snackBar_onClosed = SnackBar(content: Text('Transaction closed'));
    final _rave = RaveCardPayment(
      isDemo: true,
      encKey: "2669f72c361b7b515bcdd415",
      publicKey: "FLWPUBK-e80cf0681b403635597d059e70dc092b-X",
      //transactionRef: "FLWSECK-2669f72c361b5a4adb2a7b53656c86d4-X",
//    encKey: "c53e399709de57d42e2e36ca",
//    publicKey: "FLWPUBK-d97d92534644f21f8c50802f0ff44e02-X",
     transactionRef: "hvHPvKYaRuJLlJWSPWGGKUyaAfWeZKnm",
      amount: 100,
      email: "demo1@example.com",
      onSuccess: (response) {
        print("$response");
        print("Transaction Successful");
        if (mounted) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Transaction Sucessful!"),
              backgroundColor: Colors.green,
              duration: Duration(
                seconds: 5,
              ),
            ),
          );
        }
      },
      onFailure: (err) {
        print("$err");
        print("Transaction failed");
        Scaffold.of(context).showSnackBar(snackBar_onFailure);
      },
      onClosed: () {
        print("Transaction closed");
        Scaffold.of(context).showSnackBar(snackBar_onClosed);
      },
      context: context,
    );
    _rave.process();
  }
}