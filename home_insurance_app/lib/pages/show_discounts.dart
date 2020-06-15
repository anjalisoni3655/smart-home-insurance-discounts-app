import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/company_database.dart';
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';
import 'package:homeinsuranceapp/pages/style/custom_widgets.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:optional/optional.dart';
import 'package:homeinsuranceapp/data/helper_functions.dart';

//Offers selected by the user
Offer selectedOffer;
// Offers displayed by the company
CompanyDataBase offers = new CompanyDataBase();
// None of the discounts will be selected ( It should be globally defined because both the classes controls it )
bool disableDiscounts = true ;

class DisplayDiscounts extends StatefulWidget {
  @override
  _DisplayDiscountsState createState() => _DisplayDiscountsState();
}

class _DisplayDiscountsState extends State<DisplayDiscounts> {
  List<Offer> offersToDisplay = CompanyDataBase
      .availableOffers; // This list stores which all offers will be displayed

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
//    disableDiscounts = true ; // Whenever /showdiscounts route is called either through pop or pushNavigator
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
            Expanded(
              // To avoid renderflow in small device sizes , expanded widget is used
              flex: 6,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenwidth / 80,
                        vertical: screenheight / 80),
                    child: Text(
                      'Available Discounts',
                      style: CustomTextStyle(fontSize: 30.0),
                    ),
                  ),
                  CustomDivider(
                      height: screenheight / 100, width: screenwidth / 50),
                  SizedBox(height: screenheight / 100),
                  AllDiscounts(offersToDisplay),
                  SizedBox(height: screenheight / 50),
                ],
              ),
            ),
            //So that the last discount does not get hidden behind the floating button

            data == null
                ? Container()
                : // if data is null , this means that the user has come to this page only to see the discounts so buttons for payment should not appear
                Expanded(
                    flex: 1,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FloatingActionButton.extended(
                            heroTag: 'Discounts',
                            icon: Icon(Icons.money_off),
                            label: Text(
                              'Get Discounts',
                              style:
                                  CustomTextStyle(fontWeight: FontWeight.w900),
                            ),
                            onPressed: () async {
                             //  Get offers which the user is eligible to get after launching resource picker
                              List<Offer> allowedOffers =
                                 await getAllowedOffers(context);

                              setState(() {
                                offersToDisplay = allowedOffers;
                                disableDiscounts = false ; // Now the user can select them
                              });
                            },
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
                              style:
                                  CustomTextStyle(fontWeight: FontWeight.w900),
                            ),
                            onPressed: () {
                              //pops the current page
                              Navigator.pop(context);
                              //Pops the previous page in the stack which is choose_policy page.
                              //For now all these arguments are  send to the home page
                              Navigator.pop(context, {
                                'selectedOffer': selectedOffer,
                                'selectedPolicy': data['selectedPolicy'],
                                'userAddress': data['userAddress'],
                              });
                            },
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class AllDiscounts extends StatefulWidget {
  final List<Offer> offerList; // This is the offer list that will be displayed
  const AllDiscounts(this.offerList);

  @override
  _AllDiscountsState createState() => _AllDiscountsState();
}

class _AllDiscountsState extends State<AllDiscounts> {
  List<bool> isSelected = [];
  int currSelected = 0; // Currently no discount is selected

  void initState() {
    super.initState();
    isSelected = List.filled(widget.offerList.length,
        false); // Initially all policies are deselected
  }

  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    // If the offerList is not null then return list else return  container with text
    return (widget.offerList == null|| widget.offerList.isEmpty) ?
    Container(
      child:Text("No Offers Available"),
    )    :
    Expanded(
      child: ListView.builder(
          itemCount: widget.offerList.length,
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
                      if(disableDiscounts == false ){
                        //Current Selected state of corresponding discount is reversed
                        isSelected[currSelected] = false;
                        currSelected = index;
                        isSelected[index] = true;
                        selectedOffer = widget.offerList[index];
                      }

                    });
                  },
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 10,
                          child: Column(
                              children: (widget.offerList[index])
                                  .requirements
                                  .entries
                                  .map(
                                    (entry) => Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenheight / 80,
                                            horizontal: screenwidth / 80),
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          '${entry.key} : ${entry.value}',
                                          textAlign: TextAlign.left,
                                          style: CustomTextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${widget.offerList[index].discount} %',
                            textAlign: TextAlign.center,
                            style: CustomTextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20.0),
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
