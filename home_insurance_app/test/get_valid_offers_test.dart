import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:mockito/mockito.dart';
import 'package:sdk/sdk.dart';
import 'package:homeinsuranceapp/data/device_type.dart';
import 'package:homeinsuranceapp/data/offer_service.dart';
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:optional/optional.dart';

class MockSDK extends Mock implements SDK {}

const structure1Id = 'home-1-structure-id';
const structure1Name = "Onyx Home";
const device1Id = 'device-1-device-id';
const device1Name = 'device-1-name';
const device1Type = "sdm.devices.types.THERMOSTAT";
const device2Id = 'device-2-device-id';
const device2Name = 'device-2-name';
const device2Type = "sdm.devices.types.CAMERA";

const device1 = {
  'id': device1Id,
  'customName': device1Name,
  'type': device1Type,
  'structureId': structure1Id
};

const device2 = {
  'id': device2Id,
  'customName': device2Name,
  'type': device2Type,
  'structureId': structure1Id
};

const structure1 = {'id': structure1Id, 'customName': structure1Name};
const devicesOfStructure1 = [device1, device2];
const devicesOfStructure2 = [];

final offer1 = new Offer({
  '${deviceName[DeviceType.THERMOSTAT.index]}': 1,
  '${deviceName[DeviceType.DOORBELL.index]}': 1
}, 4);
final offer2 = new Offer({
  '${deviceName[DeviceType.THERMOSTAT.index]}': 1,
  '${deviceName[DeviceType.CAMERA.index]}': 1
}, 5);
final offer3 = new Offer({'${deviceName[DeviceType.DOORBELL.index]}': 1}, 1);

// Used as an argument passed to functions that are tested
BuildContext context;

void main() {
  setUp(() {
    globals.sdk = new MockSDK();
  });

  group('Unit test for integrating app with sdk ', () {
    //Test when authorisation through resource picker fails
    test(
        "Test 1 - Check the access when authorisation through Resource picker fails",
        () async {
      when(globals.sdk.getCredentials()).thenReturn({});
      expect(false, hasAccess());
    });

//Test for the case SDM API call throws error while getting structures and devices .
    test(
        "Test 2 - Return false when error is thrown while accessing structures of the user ",
        () async {
      //Resource picker authorisation is successful
      when(globals.sdk.getCredentials())
          .thenReturn({"accessToken": "access-token"});

      when(globals.sdk.getAllStructures()).thenThrow(new Error());
      when(globals.sdk.getAllDevices()).thenThrow(new Error());

      expect(false, hasStructures());
      expect(false, hasDevices());
    });

    //Test for the case when app has 0 structures and devices
    test(
        "Test 3 -Structures/Devices returned should be  empty  when user has no structures and devices  ",
        () async {
      //Resource picker authorisation is successful
      when(globals.sdk.getCredentials())
          .thenReturn({"accessToken": "access-token"});

      when(globals.sdk.getAllStructures())
          .thenAnswer((_) async => Future.value(Optional.empty()));
      when(globals.sdk.getAllDevices())
          .thenAnswer((_) async => Future.value(Optional.empty()));
      await linkDevices();
      expect(false, hasStructures());
      expect(false, hasDevices());
    });
  });

  //Test the canPickOffer functionality  .
  group('Unit test for checking that the offer is valid or not', () {
    test(
        "Test 1 -Return false when user has none of the device present in the offer  ",
        () async {
      globals.devices = Optional.of(devicesOfStructure1);
      selectedStructure = Optional.of(structure1);
      expect(false, canPickOffer(offer3));
    });

    test(
        "Test 2 -Return false when user has only some devices present in the offer ",
        () async {
      globals.devices = Optional.of(devicesOfStructure1);
      selectedStructure = Optional.of(structure1);
      expect(false, canPickOffer(offer1));
    });

    test(
        "Test 3 -Return true when all user devices meet the all the offer requirements   ",
        () async {
      globals.devices = Optional.of(devicesOfStructure1);
      selectedStructure = Optional.of(structure1);
      expect(true, canPickOffer(offer2));
    });
  });

  // test for getUserName functionality
  group('Unit test for displaying user name ', () {
    //Test Get userName function
    test(
        "Test 8 -Return true when all user devices meet the all the offer requirements   ",
        () async {
      when(globals.sdk.getUserDetails())
          .thenAnswer((_) async => Future.value(Optional.empty()));
      expect("YOUR NAME", await getUserName());
    });

    test(
        "Test 9 -Return true when all user devices meet the all the offer requirements   ",
        () async {
      when(globals.sdk.getUserDetails())
          .thenAnswer((_) async => Future.value(Optional.of({
                'displayName': "Khushi_Gupta",
                'email': "khushig@google.com",
                'photoUrl': "fakeurl.com"
              })));
      expect("Khushi_Gupta", await getUserName());
    });
  });
}
