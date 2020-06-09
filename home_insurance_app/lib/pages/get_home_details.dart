import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/user_home_details.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/data/company_policies.dart';
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
        decoration: InputDecoration(
            labelText:
                "Second Line Of Address"), //validator is not required as this field can be left empty
        onSaved: (String value) {
          secondLineOfAddress = value;
        });
  }

  Widget _buildCity() {
    return TextFormField(
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
              Text('Enter Your Address Details ',
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
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        // If the form is valid , all the values are saved in respective variables
                        _formKey.currentState.save();
                        //User Address object is sent to User Address class
                        UserAddress curr_user = UserAddress(firstLineOfAddress,
                            secondLineOfAddress, city, state, pincode);
                        CompanyPolicies pin_to_policy =
                            CompanyPolicies(pincode);
                        //Available policies corresponding to the pincode is saved in list .
                        List<Policy> available_policies =
                            pin_to_policy.get_policies();
                        // Available policies sent to the next for user selection .
                        Navigator.pushReplacementNamed(context, '/choosepolicy',
                            arguments: {
                              'policies': available_policies,
                            });
                      },
                      splashColor: Colors.blueGrey,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.black54,
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
