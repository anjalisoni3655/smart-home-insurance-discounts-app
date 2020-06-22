import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';
import 'package:homeinsuranceapp/pages/style/custom_widgets.dart';
import 'package:homeinsuranceapp/pages/payment_page.dart';

//This class maps each policy to a index value which is used in selecting radio buttons
class Mapping {
  Policy policyOption;
  int index;
  Mapping(int index, Policy policyOption) {
    this.index = index;
    this.policyOption = policyOption;
  }
}

Policy userChoice; // Stores the policy selected by the user

// This class displays the overall layout of the choose_policy page
class DisplayPolicies extends StatefulWidget {
  @override
  _DisplayPoliciesState createState() => _DisplayPoliciesState();
}

//This class defines the layout for entire screen except the policy list container
class _DisplayPoliciesState extends State<DisplayPolicies> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenheight = mediaQuery.size.height;
    double screenwidth = mediaQuery.size.width;

    // data stores the policies available for the user as a key-value pair.
    Map data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: CommonAppBar(),

      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: screenheight / 100, horizontal: screenheight / 100),
        margin: EdgeInsets.symmetric(
            vertical: screenheight / 100, horizontal: screenwidth / 100),
        child: Center(
          child: SingleChildScrollView(

            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenwidth / 40,
                        vertical: screenheight / 50),
                    child: Text(
                      'Available Policies',
                      style: CustomTextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
                // Returns a Divider widget whose some attributes are defined by the parameters and others take the default value
                CustomDivider(
                    height: screenheight / 100, width: screenwidth / 100),
                CustomSizedBox(height: screenheight / 100),
                RadioGroup(data),
                CustomSizedBox(height: screenheight / 50),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton.extended(
                    key: Key('Avail Smart Device Discounts'),
                    heroTag: "View",
                    onPressed: () {
                      Navigator.pushNamed(context, '/showdiscounts',
                          arguments: {
                            'selectedPolicy': userChoice,
                            'userAddress': data['userAddress'],
                          });
                    },
                    backgroundColor: Colors.lightBlueAccent,
                    icon: Icon(Icons.payment),
                    label: Text(
                      'Avail Smart Device Discounts',
                      style: CustomTextStyle(),
                    ),
                  ),
                ),
                CustomSizedBox(height: screenheight / 100),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton.extended(
                    key: Key('Payment'),
                    heroTag: "pay",
                    onPressed: () {
                      // Pop the current page and replace it by the payment page
                      Navigator
                          .pushReplacementNamed(context, Payment.id, arguments: {
                        'selectedPolicy': userChoice,
                        'userAddress': data['userAddress'],
                      }); // For now , clicking on payment takes back to the home page
                    },
                    backgroundColor: Colors.lightBlueAccent,
                    icon: Icon(Icons.payment),
                    label: Text(
                      'Skip to Payment',
                      maxLines: 2,
                      style: CustomTextStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// This class is used to display a list of policies preceded by the radio buttons
class RadioGroup extends StatefulWidget {
  Map data;
  RadioGroup(this.data);

  //  RadioGroup({Key key , this.data}):super(key:key);
  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  int choosenIndex = 0; // Stores the index corresponding to the selected policy

  List<Mapping> choices = new List<Mapping>();
  @override
  void initState() {
    super.initState();

    // If data is null , atleast assign one policy so that test file don't fails
    if (widget.data == null) {
      widget.data = {
        "policies": [Policy("No Policy", 0, 0)]
      };
    }

    userChoice = widget.data['policies']
        [0]; //By default the first policy will be displayed as selected  .
    for (int i = 0; i < widget.data['policies'].length; i++) {
      choices.add(new Mapping(i, widget.data['policies'][i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // Wraping ListView inside Container to assign scrollable screen a height and width
      width: screenWidth,
      height: 9 * screenHeight / 16,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: choices
            .map((entry) => RadioListTile(
                  key: Key('Policy ${entry.index}'),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '\n${entry.policyOption.policyName}',
                                style: CustomTextStyle(fontSize: 17.0),
                              ),
                              Text(
                                'Valid for ${entry.policyOption.validity} years',
                                style: CustomTextStyle(
                                    color: Colors.blueAccent[500],
                                    fontSize: 13.0),
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Icon(
                              Icons.attach_money,
                              color: Colors.blueAccent,
                              size: 20.0,
                            ),
                          )),
                      Expanded(
                        flex: 2,
                        child: Text('${entry.policyOption.cost}'),
                      ),
                    ],
                  ),
                  groupValue: choosenIndex,
                  activeColor: Colors.blue[500],
                  value: entry.index,
                  onChanged: (value) {
                    // A radio button gets selected only when groupValue is equal to value of the respective radio button
                    setState(() {
                      userChoice = entry.policyOption;
                      //To make groupValue equal to value for the radio button .
                      choosenIndex = value;
                    });
                  },
                ))
            .toList(),
      ),
    );
  }
}
