import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/data/device_type.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/pages/list_structures.dart';
import 'package:optional/optional.dart';

Optional<List> structures = Optional.empty();
Optional<Map> selectedStructure = Optional.empty();

// Calls resource picker and fetches devices and structures
Future<void> linkDevices() async {
  await globals.sdk.requestDeviceAccess();

  // If authorization was successful fetch all devices and structures at once.
  if (hasAccess()) {
    structures = await globals.sdk.getAllStructures();
    globals.devices = await globals.sdk.getAllDevices();
  }
}

Future<void> getDevices() async {
  globals.devices = await globals.sdk.getAllDevices();
}

// If has access but deosnt have list of structures retries to fetch list of structures
// prompts user to select structure
Future<Optional<Map>> selectStructure(BuildContext context) async {
  selectedStructure = Optional.empty();
  if (!hasAccess()) {
    return selectedStructure;
  }
  if (structures.isEmpty) {
    structures = await globals.sdk.getAllStructures();
    if (structures.isEmpty) {
      return selectedStructure;
    }
  }
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // Returns a Alert DialogueBox displaying all user structures
        return StructureAlertBox(structures.value);
      }).then((structure) async {
    selectedStructure = Optional.of(structure);
  });
  return selectedStructure;
}

// given an offer returns whether this offer is valid considering the devices that the user has
bool canPickOffer(Offer offer) {
  if (globals.devices.isEmpty) return false;
  if (selectedStructure.isEmpty) return false;

  Map<DeviceType, int> userDeviceCount = {
    DeviceType.SMOKE_CO_DETECTOR: 0,
    DeviceType.THERMOSTAT: 0,
    DeviceType.CAMERA: 0,
    DeviceType.DOORBELL: 0
  };

  for (Map device in globals.devices.value) {
    if (device['structureId'] != selectedStructure.value['id']) {
      continue;
    }
    userDeviceCount[sdmToDeviceType[device['type']]]++;
  }

  for (String deviceName in offer.requirements.keys) {
    DeviceType deviceType = getDeviceType[deviceName];
    print(offer);
    print(userDeviceCount);
    if (offer.requirements[deviceName] > userDeviceCount[deviceType]) {
      return false;
    }
  }
  return true;
}

bool hasAccess() {
  Map response = globals.sdk.getCredentials();
  if (response["accessToken"] == null) {
    return false;
  } else {
    return true;
  }
}

bool hasDevices() {
  return globals.devices.isPresent;
}

bool hasStructures() {
  return structures.isPresent;
}

bool isStructureSelected() {
  return selectedStructure.isPresent;
}

// Returns User name to payment page
Future<String> getUserName() async {
  Optional<Map> response = await globals.sdk.getUserDetails();
  if (response == Optional.empty()) {
    return "YOUR NAME";
  } else {
    Map userDetails = response.value;
    return (userDetails["displayName"]);
  }
}

// return a sorted list of offers (selectable first)
List<Offer> sortOffers(List<Offer> offers) {
  List<Offer> selectableOffers = [];
  List<Offer> unselectableOffers = [];
  for (Offer offer in offers) {
    if (canPickOffer(offer)) {
      selectableOffers.add(offer);
    } else {
      unselectableOffers.add(offer);
    }
  }
  return selectableOffers + unselectableOffers;
}
