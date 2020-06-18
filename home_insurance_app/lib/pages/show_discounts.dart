import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/company_database.dart';
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';
import 'package:homeinsuranceapp/pages/style/custom_widgets.dart';
import 'package:homeinsuranceapp/data/offer_service.dart';
import 'package:homeinsuranceapp/pages/payment_page.dart';

//Offers selected by the user
Offer selectedOffer;

// None of the discounts will be selected ( It should be globally defined because both the classes controls it )
bool disableDiscounts = true;

class DisplayDiscounts extends StatefulWidget {
  @override
  _DisplayDiscountsState createState() => _DisplayDiscountsState();
}

// This class provides overall layout of the page .
class _DisplayDiscountsState extends State<DisplayDiscounts> {
  bool accessStructure;
  List<Offer> offersToDisplay = CompanyDataBase
      .availableOffers; // This list stores which all offers will be displayed
  // When a system back button/ Back button on appBar is pressed , discounts will again be disabled .
  Future<bool> _onBackPressed() async {
    disableDiscounts = true;
    Navigator.of(context).pop(true);
  }

  @override
  void initState() {
    super.initState();
    accessStructure = hasAccess();
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    Map data = ModalRoute.of(context)
        .settings
        .arguments; // data stores the policy selected by the user as a key/value pair
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
                          horizontal: screenwidth / 100,
                          vertical: screenheight / 100),
                      child: Text(
                        'Available Offers',
                        style: CustomTextStyle(fontSize: 30.0),
                      ),
                    ),
                    CustomDivider(
                        height: screenheight / 150, width: screenwidth / 50),
                    accessStructure
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenwidth / 50,
                                vertical: screenheight / 50),
                            child: Center(
                              child: Text('Select Offer',
                                  style: CustomTextStyle(fontSize: 15.0)),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenwidth / 50,
                                vertical: screenheight / 50),
                            child: Center(
                              child: Text(
                                  'Link devices and then pick a structure to avail offer',
                                  style: CustomTextStyle(fontSize: 15.0)),
                            ),
                          ),
                    SizedBox(height: screenheight / 150),
                    AllDiscounts(offersToDisplay),
                    SizedBox(height: screenheight / 30),
                  ],
                ),
              ),
              //So that the last discount does not get hidden behind the floating button
              data == null
                  ? Container()
                  : // if data is null , this means that the user has come to this page only to see the discounts so buttons for payment should not appear
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              accessStructure
                                  ? Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: FloatingActionButton.extended(
                                          heroTag: 'home',
                                          icon: Icon(Icons.home),
                                          label: Text(
                                            'Pick Structure',
                                            style: CustomTextStyle(
                                                fontWeight: FontWeight.w900),
                                          ),
                                          onPressed: () async {
                                            //    Get offers which the user is eligible to get after launching resource picker
                                            List<Offer> allowedOffers =
                                                await selectStructure(context);
                                            setState(() {
                                              if (allowedOffers.isNotEmpty) {
                                                offersToDisplay = allowedOffers;
                                                disableDiscounts =
                                                    false; // Now the user can select them
                                              } else {
                                                //TODO Show a snackbar displaying that the user cannot get any offers right now
                                              }
                                            });
                                          },
                                          backgroundColor:
                                              Colors.lightBlueAccent,
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: FloatingActionButton.extended(
                                          heroTag: 'Discounts',
                                          icon: Icon(Icons.money_off),
                                          label: Text(
                                            'Link Devices',
                                            style: CustomTextStyle(
                                                fontWeight: FontWeight.w900),
                                          ),
                                          onPressed: () async {
                                            //    Get offers which the user is eligible to get after launching resource picker
                                            List<Offer> allowedOffers =
                                                await getAllowedOffers(context);
                                            setState(() {
                                              accessStructure = hasAccess();
                                              if (allowedOffers.isNotEmpty) {
                                                offersToDisplay = allowedOffers;
                                                disableDiscounts =
                                                    false; // Now the user can select them
                                              } else {
                                                //TODO Show a snackbar displaying that the user cannot get any offers right now
                                              }
                                            });
                                          },
                                          backgroundColor:
                                              Colors.lightBlueAccent,
                                        ),
                                      ),
                                    ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: FloatingActionButton.extended(
                                    heroTag: 'Payment',
                                    icon: Icon(Icons.arrow_forward),
                                    label: Text(
                                      'Go to Payment',
                                      style: CustomTextStyle(
                                          fontWeight: FontWeight.w900),
                                    ),
                                    onPressed: () {
                                      disableDiscounts = true;
                                      //pops the current page
                                      Navigator.pop(context);
                                      //Pops the previous page in the stack which is choose_policy page.
                                      Navigator.pop(context);
                                      //For now all these arguments are  send to the home page
                                      Navigator.pushNamed(context, Payment.id,
                                          arguments: {
                                            'selectedOffer': selectedOffer,
                                            'selectedPolicy':
                                                data['selectedPolicy'],
                                            'userAddress': data['userAddress'],
                                          });
                                    },
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: screenheight / 80),
            ],
          ),
        ),
      ),
    );
  }
}

// This class provides overall layout of the page .
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

    return Expanded(
      child: ListView.builder(
          itemCount: widget.offerList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenheight / 200, horizontal: screenwidth / 100),
              child: Card(
                color: isSelected[index]
                    ? Colors.teal[100]
                    : Colors
                        .white, // If selected then color of card is teal else no change in color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                    color: Colors.brown[100],
                    width: 1.0,
                  ),
                ),
                child: InkWell(
                  key: Key('Offer $index'),
                  onTap: () {
                    setState(() {
                      if (disableDiscounts == false) {
                        //Current selected state of clicked discount is reversed in case same discount is clicked
                        if (currSelected == index) {
                          isSelected[currSelected] = !isSelected[currSelected];
                          if (isSelected[currSelected] == true) {
                            selectedOffer = widget.offerList[index];
                          } else {
                            selectedOffer = null;
                          }
                        }
                        // In case some other discount is clicked , previous one gets unselected and clicked one gets selected
                        else {
                          isSelected[currSelected] = false;
                          currSelected = index;
                          isSelected[index] = true;
                          selectedOffer = widget.offerList[index];
                        }
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
                                          '${entry.value} ${entry.key}',
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
