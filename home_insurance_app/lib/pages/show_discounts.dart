import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/company_offers.dart';
import 'package:homeinsuranceapp/data/offer.dart';

Map data;
Offer selectedOffer ;
CompanyOffers offers = new CompanyOffers();

class DisplayDiscounts extends StatefulWidget {
  @override
  DisplayDiscountsState createState() => DisplayDiscountsState();
}

class DisplayDiscountsState extends State<DisplayDiscounts> {
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments; // data stores the policy selected by the user as a key/value pair  
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Insurance Company '),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.arrow_forward),
        label: Text(
          'Get Discounts',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15.0,
            fontWeight: FontWeight.w900,
            fontFamily:"PTSerifBI",
          ),
        ),
        onPressed: () {}, // resource picker url is launched
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Available Policies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  fontFamily: 'PTSerifBI',
                ),
              ),
            ),
            const Divider(
              color: Colors.brown,
              height: 10.0,
              thickness: 5,
              indent: 5,
              endIndent: 5,
            ),
            SizedBox(height: 50.0),
            AllDiscounts(),
            SizedBox(
                height:
                    70.0), //So that the last discount does not get hidden behind the floating button
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
  List<bool> isSelected = List.filled(offers.availableOffers.length,false) ; // If a policy is selected then its corresponding container will have different color .
  int curSelected = 0 ;

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: offers
              .availableOffers.length, // available offers is static variable
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Card(
                color:isSelected[index] ? Colors.teal[100]:Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                    color: Colors.green,
                    width: 5.0,
                  ),
                ),
                //  color: Colors.lightBlueAccent[100],
                child: InkWell(
                  onTap: () {
                    setState((){
                      isSelected[curSelected] =false;
                      curSelected=index;
                      isSelected[curSelected]=true;
                      selectedOffer=offers.availableOffers[index];
                    });
                  },
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 10,
                          child: Column(
                              children: (offers.availableOffers[index])
                                  .requirements
                                  .entries
                                  .map(
                                    (entry) => Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                          margin: EdgeInsets.all(0.0),
                                          padding: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              // color: Colors.lightBlueAccent[100],
                                              ),
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
                            '${offers.availableOffers[index].discount} %',
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
