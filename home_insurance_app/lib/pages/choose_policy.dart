import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';

//This class maps each policy to a index value which is used in selecting radio buttons
class Mapping {
  Policy policyOption;
  int index;
  Mapping(int index, Policy policyOption) {
    this.index = index;
    this.policyOption = policyOption;
  }
}

class DisplayPolicies extends StatefulWidget {
  @override
  _DisplayPoliciesState createState() => _DisplayPoliciesState();
}

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {}, // Goes to the payment page
        backgroundColor: Colors.lightBlueAccent,
        icon: Icon(Icons.payment),
        label: Text(
          'Payment',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenwidth / 30, vertical: screenheight / 40),
              child: Text(
                'Available Policies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(height: screenheight / 40),
            GestureDetector(
              onTap: () => print(
                  "Get smart device discounts"), // Goes to the smart device discounts page
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.lightBlueAccent[100],
                  ),
                  height: 60.0,
                  width: 350.0,
                  child: Center(
                    child: Text('Get Smart Devices Discounts',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
            ),
            SizedBox(height: screenheight / 40),
            RadioGroup(data),
          ],
        ),
      ),
    );
  }
}

// This class is used to display a list of policies preceded by the radio buttons
class RadioGroup extends StatefulWidget {
  final Map data;
  const RadioGroup(this.data);
  //  RadioGroup({Key key , this.data}):super(key:key);
  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  Policy userChoice; // Stores the policy selected by the user
  int choosenIndex = 0; // Stores the index corresponding to the selected policy
  List<Mapping> choices = new List<Mapping>();
  @override
  void initState() {
    super.initState();
    userChoice = widget.data['policies']
        [0]; //By default the first policy will be displayed as selected  .
    for (int i = 0; i < widget.data['policies'].length; i++) {
      choices.add(new Mapping(i, widget.data['policies'][i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: choices
                .map((entry) => RadioListTile(
                      title: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 8,
                            child: Text(
                              '\n${entry.policyOption.policyName} \nValid for ${entry.policyOption.validity} years',
                              style: TextStyle(
                                color: Colors.brown,
                                fontSize: 17.0,
                              ),
                            ),
                          ),
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
                          print(userChoice.policyName);
                        });
                      },
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
