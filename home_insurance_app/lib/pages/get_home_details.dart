import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/user_home_details.dart';
import 'package:homeinsuranceapp/components/css.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;

String firstLineOfAddress;
String secondLineOfAddress;
String city;
String state;
int pincode;

String validateAddress(String value) {
  if (value.isEmpty) {
    return 'This Field cannot be empty';
  } else if (value.contains(RegExp(r'[A-Z]')) ||
      value.contains(RegExp(r'[a-z]')) ||
      value.contains(RegExp(r'-,/\\()'))) {
    return null;
  } else {
    return 'Please enter a valid address';
  }
}

String validatePincode(String pincode) {
  Pattern pattern = r'[.,|_]';
  RegExp regex = RegExp(pattern);
  if (pincode.isEmpty) {
    return 'This field cannot be empty';
  } else {
    if (regex.hasMatch(pincode)) {
      return 'Please enter a valid pincode';
    } else {
      int pin = int.parse(pincode);
      if (pin > 100000 && pin < 999999) {
        // Check the no.of digits is 6
        return null;
      } else
        return 'Please enter a valid pincode';
    }
  }
}

// Widget for getting , validating and storing User Address
class HomeDetails extends StatefulWidget {
  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildAddressFirstLine() {
    return TextFormField(
        key: Key("First Address Line"),
        decoration: InputDecoration(labelText: "First Line Of Address"),
        validator: validateAddress,
        onSaved: (String value) {
          firstLineOfAddress = value;
        });
  }

  Widget _buildAddressSecondLine() {
    return TextFormField(
        key: Key("Second Address Line"),
        decoration: InputDecoration(
            labelText:
                "Second Line Of Address"), //validator is not required as this field can be left empty
        validator: validateAddress,
        onSaved: (String value) {
          secondLineOfAddress = value;
        });
  }

  Widget _buildCity() {
    return TextFormField(
        key: Key("City"),
        decoration: InputDecoration(labelText: " City "),
        validator: validateAddress,
        onSaved: (String value) {
          city = value;
        });
  }

  Widget _buildState() {
    return TextFormField(
        key: Key("State"),
        decoration: InputDecoration(labelText: "State/Union Territory"),
        validator: validateAddress,
        onSaved: (String value) {
          state = value;
        });
  }

  Widget _buildPincode() {
    return TextFormField(
        key: Key("Pincode"),
        decoration: InputDecoration(labelText: "Pincode"),
        keyboardType: TextInputType.number,
        validator: validatePincode,
        onSaved: (String value) {
          pincode = int.tryParse(value);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Home Insurance Company'),
        centerTitle: true,
        backgroundColor: kAppbarColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              Text('Enter Your Address Details ',
                  style: kGetDetailsHeadTextStyle),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildAddressFirstLine(),
                    _buildAddressSecondLine(),
                    _buildCity(),
                    _buildState(),
                    _buildPincode(),
                    SizedBox(height: 100),
                    RaisedButton(
                      key: Key('Submit'),
                      color: Colors.brown,
                      textColor: Colors.white,
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        // If the form is valid , all the values are saved in respective variables
                        _formKey.currentState.save();

                        //User Address object is sent to User Address class
                        UserAddress curr_user_address = UserAddress(
                            firstLineOfAddress,
                            secondLineOfAddress,
                            city,
                            state,
                            pincode);
                        //Available policies corresponding to the pincode is saved in list .
                        globals.policyDao.getPolicies(pincode).then((policies) {
                          Navigator.pushReplacementNamed(
                              context, '/choosepolicy', arguments: {
                            'policies': policies,
                            'userAddress': curr_user_address
                          });
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      splashColor: Colors.blueGrey,
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                          //color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
