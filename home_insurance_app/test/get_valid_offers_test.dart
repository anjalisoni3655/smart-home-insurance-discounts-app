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
  'type': device1Type
};

const device2 = {
  'id': device2Id,
  'customName': device2Name,
  'type': device2Type
};

const structure1 = {'id': structure1Id, 'customName': structure1Name};
const devicesOfStructure1 = [device1, device2];
const allStructures = [structure1];

List validOffersResult1 = [
  new Offer({
    '${deviceName[DeviceType.THERMOSTAT.index]}': 1,
    '${deviceName[DeviceType.CAMERA.index]}': 1
  }, 4),
  new Offer({'${deviceName[DeviceType.THERMOSTAT.index]}': 1}, 1),
  new Offer({'${deviceName[DeviceType.CAMERA.index]}': 1}, 1)
];
const validOffersResultEmpty = [];

// Used as an argument passed to functions that are tested
BuildContext context;

void main() {
  setUp(() {
    globals.sdk = new MockSDK();
  });

  group(
      'Unit test for checking the business logic for returning valid offers to the user ',
      () {

    //Test when authorisation through resource picker fails
    test(
        "Test 1 - Return Empty list of Offers when authorisation through Resource picker fails",
        () async {
      when(globals.sdk.requestDeviceAccess())
          .thenAnswer((_) async => Future.value("authorization failed"));

      expect(validOffersResultEmpty, await getAllowedOffers(context));
    });

    //Test for the case when app has access to none of the user structures
    test("Test 2 - Return Empty list of Offers when user has no structure ",
        () async {

      //Resource picker authorisation is successful
      when(globals.sdk.requestDeviceAccess())
          .thenAnswer((_) async => Future.value('authorization successful'));

      when(globals.sdk.getAllStructures())
          .thenAnswer((_) async => Future.value(Optional.empty()));

      expect(validOffersResultEmpty, await getAllowedOffers(context));
    });

    //Test for the case when  app don't has the access token to get user structures
    test(
        "Test 3 - Return Empty list of Offers when error is thrown while accessing structures of the user ",
        () async {
          //Resource picker authorisation is successful
      when(globals.sdk.requestDeviceAccess())
          .thenAnswer((_) async => Future.value('authorization successful'));

      when(globals.sdk.getAllStructures()).thenThrow(new Error());

      expect(validOffersResultEmpty, await getAllowedOffers(context));
    });

    //Test when valid offers are returned
    test("Test 4 - List of valid Offers is non- empty ",
        () async {
      when(globals.sdk.getDevicesOfStructure('home-1-structure-id')).thenAnswer(
          (_) async => Future.value(Optional.of(devicesOfStructure1)));

      // Checking the equality of thw two list .
      List appResponse = await getValidOffers(structure1);
      List expectedResponse = validOffersResult1;
      bool isSame = false;
      if (appResponse.length == expectedResponse.length) {
        for (int i = 0; i < appResponse.length; i++) {
          if (!(identical(appResponse[i], expectedResponse[i]))) break;
        }
        isSame = true;
      }
      expect(true, isSame);
    });

    //Test when the  app has acess to none of the devices of structure selected by the user .
    test("Test 5 - Get Valid Offers when structure has 0 devices ", () async {
      when(globals.sdk.getDevicesOfStructure('home-1-structure-id'))
          .thenAnswer((_) async => Future.value(Optional.empty()));

      expect(validOffersResultEmpty, await getValidOffers(structure1));
    });

    //Test when accessing user devices fails .
    test(
        "Test 6 - Get Valid Offers when error is thrown while getting devices of structure  ",
        () async {
      when(globals.sdk.getDevicesOfStructure('home-1-structure-id'))
          .thenThrow(new Error());
      expect(validOffersResultEmpty, await getValidOffers(structure1));
    });
  });
}
