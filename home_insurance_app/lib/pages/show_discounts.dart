import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/company_offers.dart';

Map data;
CompanyOffers offers= new CompanyOffers();

class DisplayDiscounts extends StatefulWidget {
  @override
  DisplayDiscountsState createState() => DisplayDiscountsState();
}

class DisplayDiscountsState extends State<DisplayDiscounts> {
  @override
  void initState(){
    super.initState();
    print(offers.noOfOffers);
    print("jkwxkc");
  }
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
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
            color: Colors.black54,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
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
                'Available Discount Offers',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(height: 50.0),
          /*  Expanded(
              child: ListView.builder(
                  itemCount: 10,//CompanyOffers.availableOffers.length , // available offers is static variable
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                      child: Card(
                        child: ListTile(
                            onTap: () {},
                            title: Text(
                                '${offers.availableOffers[index].discount}'),
                            leading: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.dehaze,
                                color: Colors.lightBlue,
                              ),
                            )),
                      ),
                    );
                  }),
            ),*/
          ],
        ),
      ),
    );
    ;
  }
}
