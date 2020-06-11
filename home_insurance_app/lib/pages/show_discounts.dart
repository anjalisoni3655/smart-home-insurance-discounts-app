import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/company_database.dart';
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';
import 'package:homeinsuranceapp/pages/payment_page.dart';

//Offers selected by the user
List<Offer> selectedOffers = new List<Offer>();
// Offers displayed by the company
CompanyDataBase offers = new CompanyDataBase();

class DisplayDiscounts extends StatefulWidget {
  @override
  DisplayDiscountsState createState() => DisplayDiscountsState();
}

class DisplayDiscountsState extends State<DisplayDiscounts> {
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    Map data = ModalRoute.of(context)
        .settings
        .arguments; // data stores the policy selected by the user as a key/value pair
    return Scaffold(
      appBar: CommonAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: screenheight / 80, horizontal: screenwidth / 80),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenwidth / 80, vertical: screenheight / 80),
              child: Text(
                'Available Discounts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  fontFamily: 'PTSerifBI',
                ),
              ),
            ),
            Divider(
              color: Colors.brown,
              height: screenheight / 100,
              thickness: screenheight / 100,
              indent: screenwidth / 50,
              endIndent: screenwidth / 50,
            ),
            SizedBox(height: screenheight / 100),
            AllDiscounts(),
            SizedBox(
                height: screenheight /
                    50), //So that the last discount does not get hidden behind the floating button
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: FloatingActionButton.extended(
                    heroTag: 'Discounts',
                    icon: Icon(Icons.money_off),
                    label: Text(
                      'Get Discounts',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: "PTSerifBI",
                      ),
                    ),
                    onPressed: () {}, // resource picker url is launched
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton.extended(
                    heroTag: 'Payment',
                    icon: Icon(Icons.arrow_forward),
                    label: Text(
                      'Go to Payment',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: "PTSerifBI",
                      ),
                    ),
                    onPressed: () {
                      // if data is null , it means that user has not selected any policy and user just wants to view the discounts .
                      if (data != null) {
                        //calculate total discount
                        int totalDiscount =
                            offers.getTotalDiscount(selectedOffers);
                        // get total Amount paid
                        double finalAmount = offers.getFinalCost(
                            data['selectedPolicy'].cost, totalDiscount);
                        //pops the current page
                        Navigator.pop(context);

                        //Pops the previous page in the stack which is choose_policy page.
                        //For now all these argumenst are  send to the home page
                       // Navigator.pushNamed(context,Payment.id);
                        Navigator.pushNamed(
                            context,
                            Payment.id,
                            arguments: {
                              'totalDiscount': totalDiscount,
                              'amountpaid': finalAmount,
                              'selectedPolicy': data['selectedPolicy'],

                            }
                        );
                      }

                    },
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AllDiscounts extends StatefulWidget {
  @override
  _AllDiscountsState createState() => _AllDiscountsState();
}

class _AllDiscountsState extends State<AllDiscounts> {
  List<bool> isSelected = List.filled(CompanyDataBase.availableOffers.length,
      false); // Initially all policies are deselected

  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: ListView.builder(
          itemCount: CompanyDataBase.availableOffers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Card(
                color: isSelected[index]
                    ? Colors.teal[100]
                    : Colors
                        .white, // If selected then color of card is teal else no change in color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                    color: Colors.green,
                    width: 5.0,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      //Current Selected state of corresponding discount is reversed
                      isSelected[index] = !isSelected[index];
                      if (isSelected[index] == true)
                        selectedOffers
                            .add(CompanyDataBase.availableOffers[index]);
                      else {
                        // It is deselected , so remove from list
                        selectedOffers.removeAt(selectedOffers
                            .indexOf(CompanyDataBase.availableOffers[index]));
                      }
                    });
                  },
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 10,
                          child: Column(
                              children: (CompanyDataBase.availableOffers[index])
                                  .requirements
                                  .entries
                                  .map(
                                    (entry) => Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: screenheight / 100,
                                              horizontal: screenwidth / 100),
                                          padding: EdgeInsets.symmetric(
                                              vertical: screenheight / 100,
                                              horizontal: screenwidth / 100),
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            '${entry.key} : ${entry.value}',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "PTSerifBI",
                                              fontSize: 17,
                                            ),
                                          )),
                                    ),
                                  )
                                  .toList()),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${CompanyDataBase.availableOffers[index].discount} %',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
