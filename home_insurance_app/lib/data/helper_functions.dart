import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/data/company_database.dart';
import 'package:optional/optional.dart';

// Function for calling resource picker
Future<bool> callResourcePicker() async {
  String status = await globals.user.requestDeviceAccess();
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
  Set<String> types = {}; // Stores all unique 'types' of devices that user has
  for (int i = 0; i < devices.length; i++) {
    String type = devices[i]["type"].substring(
        18,
        devices[i]["type"]
            .length); // Remove "sdm.devices.types." from the type trait of the device
    types.add(type);
  }
  // Check which offer is valid
  bool isValid = true;

  for (int i = 0; i < allOffers.length; i++) {
    isValid = true;
    for (var k in allOffers[i].requirements.keys) {
      if (!(types.contains("$k"))) {
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
