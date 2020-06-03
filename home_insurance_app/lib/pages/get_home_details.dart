import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/user_home_details.dart';
import 'package:homeinsuranceapp/data/policies.dart';


String address ;
String state ;
int  pincode;
int periodOfInsurance ;
int mobileNo ;
class HomeDetails extends StatefulWidget {
  @override
 
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildaddress(){
    return TextFormField(
      decoration:InputDecoration(labelText: "Address"),
      validator:(String value){
        if(value.isEmpty){
          return 'Address is Required' ;
        }
      },
      onSaved:(String value){
      address = value;
      }) ;
  }
  Widget _buildstate(){
    return TextFormField(
      decoration:InputDecoration(labelText: "State/Union Territory"),
      validator:(String value){
        if(value.isEmpty){
          return 'State/Union Territory is Required' ;
        }
      },
      onSaved:(String value){
      state = value;
      }) ;
  }
  Widget _buildpincode(){
    return TextFormField(
      decoration:InputDecoration(labelText: "Pincode"),
      keyboardType : TextInputType.number,
      validator:(String value){
        int pin = int.tryParse(value);
        if(value.isEmpty||pin<100000||pin>999999){    // Check the no.of digits is 6
          return 'Please enter a valid pincode' ; 
        }
      },
      onSaved:(String value){
      pincode = int.tryParse(value);
      }) ;
  }
  Widget _buildperiodOfInsurance(){
    return TextFormField(
      decoration:InputDecoration(labelText: "Period Of Insurance (1-15 years)"),
      keyboardType : TextInputType.number,
      validator:(String value){
        int period = int.tryParse(value);
        if(value.isEmpty||period<0||period>15){      
          return 'Please enter a valid Period ' ; 
        }
      },
      onSaved:(String value){
      periodOfInsurance =int.tryParse(value);
      }) ;       //DropDown list 
  }
  Widget _buildmobileNo(){
    return TextFormField(
      decoration:InputDecoration(labelText: "Mobile Number"),
      keyboardType : TextInputType.number ,
      validator:(String value){
        int phoneno = int.tryParse(value);
        if(value.isEmpty||(phoneno>9999999999)){
            return 'Enter a valid Mobile Number' ; 
        }
      },
      onSaved:(String value){
      mobileNo =int.tryParse(value);
      }) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding :false,
      appBar:AppBar(
        title:Text('Home Insurance Company'),
        centerTitle: true ,
        backgroundColor: Colors.brown,
        ),
      body :SingleChildScrollView(
          child: Container(
          margin:EdgeInsets.all(24),
          child:Column(
            children: <Widget>[
              Text(
                'Address Details',
                style:TextStyle(
                  fontSize:20.0,
                  fontWeight:FontWeight.bold,
                  color:Colors.black87,
                )
              ),
              Form(
                key: _formKey ,
                child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[
                _buildaddress(),
                _buildstate(),
                _buildpincode(),
                _buildmobileNo(),
                _buildperiodOfInsurance(),
                SizedBox(height:100),
                RaisedButton(
                  onPressed:(){
                    if(!_formKey.currentState.validate()){
                      return;
                    }
                    // If the form is valid , all the values are saved in respective variables
                    _formKey.currentState.save(); 
                    //User Home details object is sent to User Home Details class 
                    UserDetails curr_user = UserDetails(address , state , pincode , periodOfInsurance ,mobileNo );
                    Policy pin_to_policy = Policy(pincode);
                    //Available policies corresponding to the pincode is saved in list . 
                    List<String> available_policies = pin_to_policy.get_policies();
                    // Available policies sent to the next for user selection .
                     Navigator.pushReplacementNamed(context, '/choosepolicy',arguments:{
                      'policies':available_policies,
                    });

                  },

                  splashColor: Colors.blueGrey,
                  child:Text('Submit',
                  style:TextStyle(
                    color:Colors.black54,
                    fontSize:16,
                    ),
                  ) ,
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