import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;
import 'package:mockito/mockito.dart';
import 'package:sdk/sdk.dart';
import'package:homeinsuranceapp/data/device_type.dart';
import 'package:homeinsuranceapp/data/offer_service.dart';
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:optional/optional.dart';

class MockSDK extends Mock implements SDK {}

const structure1Id = 'home-1-structure-id';
const structure1Name = "Onyx Home";
const structure2Id = 'home-2-structure-id';
const structure2Name = 'Second Home';
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
const structure2 = {'id': structure2Id, 'customName': structure2Name};
const devicesOfStructure1 = [device1,device2];
const devicesOfStructure2 = [];
const allStructures = [structure1 , structure2];
List  validOffersResult1 =[new Offer({'${deviceName[DeviceType.THERMOSTAT.index]}': 1}, 1),new Offer({
  '${deviceName[DeviceType.THERMOSTAT.index]}': 1,
  '${deviceName[DeviceType.CAMERA.index]}': 1
}, 4),new Offer({'${deviceName[DeviceType.CAMERA.index]}': 1}, 1)];
const validOffersResultEmpty = [] ;
BuildContext context ;

void main() {
  setUp(() {
    globals.sdk = new MockSDK();
  });

  group('Unit test for checking the business logic for returning valid offers to the user ', () {

    test("Test 1 - Return Empty list of Offers when authorisation through Resource picker fails", () async {
      when(callResourcePicker()).thenAnswer(
              (_) async => Future.value(false));

      expect(validOffersResultEmpty , await getAllowedOffers(context));

    });

//    test("Test 2 - Return Empty list of Offers when user has no structure ", () async {
//      when(callResourcePicker()).thenAnswer(
//              (_) async => Future.value(true));
//      when(globals.sdk.getAllStructures()).thenAnswer(
//              (_) async => Future.value(Optional.empty()));
//
//      expect(validOffersResultEmpty, await getAllowedOffers(context));
//
//    });
//
//    test("Test 3 - Return Empty list of Offers when error is thrown while accessing structures of the user ", () async {
//      when(callResourcePicker()).thenAnswer(
//              (_) async => Future.value(true));
//      when(globals.sdk.getAllStructures()).thenThrow(new Error());
//
//      expect(validOffersResultEmpty , await getAllowedOffers(context));
//
//    });
//
//    test("Test 4 - Get Valid Offers when structure has atleast 1 device", () async {
//      when(globals.sdk.getDevicesOfStructure('home-1-structure-id')).thenAnswer(
//          (_) async => Future.value(Optional.of(devicesOfStructure1)));
//
//      expect(validOffersResult1 , await getValidOffers(structure1));
//
//    });
//
//    test("Test 5 - Get Valid Offers when structure has 0 devices ", () async {
//      when(globals.sdk.getDevicesOfStructure('home-2-structure-id')).thenAnswer(
//              (_) async => Future.value(Optional.of(devicesOfStructure2)));
//
//      expect( validOffersResultEmpty , await getValidOffers(structure1));
//
//    });
//
//    test("Test 6 - Get Valid Offers when error is thrown while getting devices of structure  ", () async {
//      when(globals.sdk.getDevicesOfStructure('home-2-structure-id')).thenThrow(new Error());
//
//      expect(validOffersResultEmpty , await getValidOffers(structure1));
//    });

  });

}

