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

Map data = {};

class _DisplayPoliciesState extends State<DisplayPolicies> {
  @override
  Widget build(BuildContext context) {
    // data stores the policies available for the user as a key-value pair.
    data = ModalRoute.of(context).settings.arguments;
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
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Available Policies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(height: 50.0),
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
            SizedBox(height: 20.0),
            RadioGroup(),
          ],
        ),
      ),
    );
  }
}

// This class is used to display a list of policies preceded by the radio buttons
class RadioGroup extends StatefulWidget {
  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  Policy userChoice = data['policies']
      [0]; //By default the first policy will be displayed as selected  .
  int choosenIndex = 0;
  List<Mapping> choices = new List<Mapping>();
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < data['policies'].length; i++) {
      choices.add(new Mapping(i, data['policies'][i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: choices
                .map((data) => RadioListTile(
                      title: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 8,
                            child: Text(
                              '\n${data.policyOption.policyName} \nValid for ${data.policyOption.validity} years',
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
                            child: Text('${data.policyOption.cost}'),
                          ),
                        ],
                      ),
                      groupValue: choosenIndex,
                      activeColor: Colors.blue[500],
                      value: data.index,
                      onChanged: (value) {
                        // A radio button gets selected only when groupValue is equal to value of the respective radio button
                        setState(() {
                          userChoice = data.policyOption;
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
