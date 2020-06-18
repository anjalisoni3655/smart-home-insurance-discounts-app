import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/data/company_database.dart';
import 'package:optional/optional.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/list_structures.dart';

Future<List> getAllowedOffers(BuildContext context) async {
  List<Offer> allowedOffers = [];
  // Call the resource picker
  bool isAuthorise = await callResourcePicker();
  if (isAuthorise) {
    allowedOffers = await selectStructure(context);
  }
  // In case authorisation is not successful or structure is empty , empty list is returned , else list with desired offers is returned
  return (allowedOffers);
}

Future<List> selectStructure(BuildContext context) async {
  List<Offer> allowedOffers = [];
  Optional<List> response;
  try {
    response = await globals.sdk.getAllStructures();
  } catch (e) {
    //TODO  Snackbar showing  "NO HOMES FOUND"
    response = Optional.empty();
  }
  if (response != Optional.empty()) {
    List structures = response.value;
//    Helper function to show dialogue box for displaying structure list
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          // Returns a Alert DialogueBox displaying all user structures
          return StructureAlertBox(structures);
        }).then((selectedStructure) async {
//Send the structure ( id and name ) and get all offers which the user can get
      allowedOffers = await getValidOffers(selectedStructure);
    });
  }
  return (allowedOffers);
}

// Function for calling resource picker
Future<bool> callResourcePicker() async {
  String status = await globals.sdk.requestDeviceAccess();
  if (status == 'authorization successful') {
    //TODO : Redirect from the resource picker
    return true;
  } else {
    return false;
  }
}

// Returns the List of valid offers that user is eligible to get
Future<List> getValidOffers(Map structure) async {
  List<Offer> allowedOffers = [];
  List<Offer> allOffers = CompanyDataBase.availableOffers;

  Optional<List> response;
  try {
    response = await globals.sdk.getDevicesOfStructure(structure["id"]);
  } catch (e) {
    //TODO - Snackbar showing NO ACCESS TO DEVICES
    response = Optional.empty();
  }
  if (response != Optional.empty()) {
    List devices = response.value;
    //Stores all unique 'types' of devices along with their respective count
    Map<String, int> userDevices = {};
    for (int i = 0; i < devices.length; i++) {
//    Remove "sdm.devices.types." from the type trait of the device
      String type = devices[i]["type"].substring(18, devices[i]["type"].length);
      if (userDevices.containsKey(type)) {
        userDevices[type]++;
      }

//    if device type is not present , create a new key in map
      else {
        userDevices[type] = 1;
      }
    }

//  Check which offer is valid . If valid add it to the list of allowed Offers .
    bool isValid = true;

    for (int i = 0; i < allOffers.length; i++) {
      isValid = true;
      for (var k in allOffers[i].requirements.keys) {
        int count = userDevices[k] == null ? 0 : userDevices[k];
        if (count < allOffers[i].requirements[k]) {
          isValid = false;
          break;
        }
      }
      if (isValid == true) {
        allowedOffers.add(allOffers[i]);
      }
    }
  }

// In case devices of the particular structure is 0 , empty list is returned .
  return (allowedOffers);
}

// Returns User name to payment page
Future<String> getUserName() async {
  Optional<Map> response = await globals.sdk.getUserDetails();
  print(response);
  if (response == Optional.empty()) {
    return "YOUR NAME";
  } else {
    Map userDetails = response.value;
    return (userDetails["displayName"]);
  }
}

bool hasAccess() {
  Map response = globals.sdk.getCredentials();
  if (response["accessToken"] == null) {
    return false;
  } else {
    return true;
  }
}
