import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/database_utilities.dart';
import 'package:homeinsuranceapp/data/user_home_details.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';

String firstLineOfAddress;
String secondLineOfAddress;
String city;
String state;
int pincode;

// Widget for getting , validating and storing User Address
class HomeDetails extends StatefulWidget {
  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildAddressFirstLine() {
    return TextFormField(
        key: Key('First Address Line'), // Used for testing
        decoration: InputDecoration(labelText: "First Line Of Address"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Address is Required';
          }
        },
        onSaved: (String value) {
          firstLineOfAddress = value;
        });
  }

  Widget _buildAddressSecondLine() {
    return TextFormField(
        key: Key('Second Address Line'), // Used for testing
        decoration: InputDecoration(
            labelText:
                "Second Line Of Address"), //validator is not required as this field can be left empty
        onSaved: (String value) {
          secondLineOfAddress = value;
        });
  }

  Widget _buildCity() {
    return TextFormField(
        key: Key('City'), // Used for testing
        decoration: InputDecoration(labelText: " City "),
        validator: (String value) {
          if (value.isEmpty) {
            return 'City is Required';
          }
        },
        onSaved: (String value) {
          city = value;
        });
  }

  Widget _buildState() {
    return TextFormField(
        key: Key('State'), // Used for testing
        decoration: InputDecoration(labelText: "State/Union Territory"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'State/Union Territory is Required';
          }
        },
        onSaved: (String value) {
          state = value;
        });
  }

  Widget _buildPincode() {
    return TextFormField(
        key: Key('Pin-code'), // Used for testing
        decoration: InputDecoration(labelText: "Pincode"),
        keyboardType: TextInputType.number,
        validator: (String value) {
          int pin = int.tryParse(value);
          if (value.isEmpty || pin < 100000 || pin > 999999) {
            // Check the no.of digits is 6
            return 'Please enter a valid pincode';
          }
        },
        onSaved: (String value) {
          pincode = int.tryParse(value);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: CommonAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              Text('Enter Your Address Details',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  )),
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
                        getPolicies(pincode).then((policies) {
                          Navigator.pushReplacementNamed(
                              context, '/choosepolicy',
                              arguments: {
                                'policies': policies,
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
