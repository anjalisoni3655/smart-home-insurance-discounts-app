import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/data/company_database.dart';
import 'package:optional/optional.dart';
import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/list_structures.dart';

Future<List> getAllowedOffers(BuildContext context) async {
  //Call the resource picker
  bool isAuthorise = await callResourcePicker(context);
  if (true) {
    List<Offer> allowedOffers;
//  Optional<List> response =
//      await globals.user.getAllStructures();
//  List structures = response.value;
    List structures = [
      {"id": "12345", "customName": "Onyx Home"},
      {"id": "23456", "customName": "Second Home"}
    ];
// Helper function to show dialogue for displaying structure list
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
// Returns a Alert DialogueBox displaying all user structures
          return StructureAlertBox(structures);
        }).then((selectedStructure) async {
// Send the structure ( id and name ) and get all offers which the user can get
      allowedOffers = await getValidOffers(selectedStructure);
    });
    return (allowedOffers);
  }
}

// Function for calling resource picker
Future<bool> callResourcePicker(BuildContext context) async {
  String status = await globals.user.requestDeviceAccess(context);
  print(status);
  if (status == 'authorization successful') {
    //TODO : Redirect from the resource picker
    return true;
  } else {
    //TODO Show a snackbar displaying error
    return false;
  }
}

// Returns the List of valid offers that user is eligible to get
Future<List> getValidOffers(Map structure) async {
  List<Offer> allowedOffers = [];
  List<Offer> allOffers = CompanyDataBase.availableOffers;
//  Optional<List> res =
//      await globals.user.getDevicesOfStructure(structure["id"]);
//  List devices = res.value;
  List devices = [
    {"type": "sdm.devices.types.THERMOSTAT"},
    {"type": "sdm.devices.types.CAMERA"}
  ];
  Set<String> userDeviceTypes = {}; // Stores all unique 'types' of devices that user has
  for (int i = 0; i < devices.length; i++) {
//    Remove "sdm.devices.types." from the type trait of the device
    String type = devices[i]["type"].substring(
        18,
        devices[i]["type"]
            .length);
    userDeviceTypes.add(type);
  }
//  Check which offer is valid
  bool isValid = true;

  for (int i = 0; i < allOffers.length; i++) {
    isValid = true;
    for (var k in allOffers[i].requirements.keys) {
      if (!(userDeviceTypes.contains("$k"))) {
        isValid = false;
        print("$i break");
        break;
      }
    }
    if (isValid == true) {
      allowedOffers.add(allOffers[i]);
    }
  }
  return (allowedOffers);
}
