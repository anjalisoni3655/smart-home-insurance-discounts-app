import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sdk/services/access_devices.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

MockClient mockClient;
MockResponse mockResponse;
AccessDevices accessDevices;

// Naming enterprises, structures and devices
const url = 'https://sdm-api.googleapis.com/';
const enterpriseId = 'sdm-test';
const structure1Id = 'home-1-structure-id';
const structure1Name = 'home-1';
const structure2Id = 'home-2-structure-id';
const structure2Name = 'home-2';
const device1Id = 'device-1-device-id';
const device1Name = 'device-1-name';
const device1Type = "sdm.devices.types.THERMOSTAT";
const device2Id = 'device-2-device-id';
const device2Name = 'device-2-name';
const device2Type = "sdm.devices.types.CAMERA";

// Valid GET Request URLs
const String getAllDevicesUrl = "${url}enterprises/$enterpriseId/devices";
const String getAllStructuresUrl = "${url}enterprises/$enterpriseId/structures";
const String getDevice1StatusUrl =
    "${url}enterprises/$enterpriseId/devices/$device1Id";

// Responses returned by the SDM API
const device1Response =
    '{"name" : "/enterprises/$enterpriseId/devices/$device1Id","type" : "$device1Type", "assignee": "/enterprises/$enterpriseId/structures/$structure1Id","traits" : {"sdm.devices.traits.DeviceConnectivityTrait" : {"status" : "ONLINE"}, "sdm.devices.traits.DeviceInfoTrait": {"customName": "$device1Name"}}}';
const device2Response =
    '{"name" : "/enterprises/$enterpriseId/devices/$device2Id","type" : "$device2Type", "assignee": "/enterprises/$enterpriseId/structures/$structure2Id","traits" : {"sdm.devices.traits.DeviceConnectivityTrait" : {"status" : "OFFLINE"}, "sdm.devices.traits.DeviceInfoTrait": {"customName": "$device2Name"}}}';
const allDevicesListResponse =
    '{ "devices": [$device1Response, $device2Response] }';
const structure1Response =
    '{"name": "enterprises/$enterpriseId/structures/$structure1Id","traits": {"sdm.structures.traits.Info": {"customName": "$structure1Name"}}}';
const structure2Response =
    '{"name": "enterprises/$enterpriseId/structures/$structure2Id","traits": {"sdm.structures.traits.Info": {"customName": "$structure2Name"}}}';
const allStructuresListResponse =
    '{ "structures": [$structure1Response, $structure2Response] }';

// Expected results from the SDK
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
  'structureId': structure2Id
};
const allDevicesResult = [device1, device2];
const devicesOfStructure1Result = [device1];
const structure1Result = {'id': structure1Id, 'customName': structure1Name};
const structure2Result = {'id': structure2Id, 'customName': structure2Name};
const allStructuresResult = [structure1Result, structure2Result];

void main() {
  // Default setup
  setUp(() {
    mockClient = new MockClient();
    mockResponse = new MockResponse();
    when(mockClient.get(getAllDevicesUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) => Future.value(mockResponse));
    when(mockClient.get(getAllStructuresUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) => Future.value(mockResponse));
    when(mockClient.get(getDevice1StatusUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) => Future.value(mockResponse));

    accessDevices = new AccessDevices(mockClient, enterpriseId,
        accessDevicesTimeoutDuration: new Duration(milliseconds: 100),
        url: url);
    accessDevices.setCredentials(
        {"accessToken": "accessToken", "refreshToken": "refreshToken"});
  });

  test("test 1.1: get all devices successful http request", () async {
    // defining behaviour
    when(mockResponse.body).thenReturn(allDevicesListResponse);

    // testing
    expect((await accessDevices.getAllDevices()).value, allDevicesResult);
  });

  test("test 1.2: get all devices exception on http request", () async {
    // Defining behaviour: throws error
    when(mockClient.get(getAllDevicesUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenThrow(new Exception());

    // testing
    expect((await accessDevices.getAllDevices()).isEmpty, true);
  });

  test("test 1.3: get all devices timeout on http request", () async {
    // Defining behaviour: returns a response after 200 ms
    when(mockClient.get(getAllDevicesUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    }); // Mock response returns a body
    when(mockResponse.body).thenReturn(allDevicesListResponse);

    // testing
    expect((await accessDevices.getAllDevices()).isEmpty, true);
  });

  test("test 2.1: get all structures successful http request", () async {
    // Defining behaviour
    when(mockResponse.body).thenReturn(allStructuresListResponse);

    // testing
    expect((await accessDevices.getAllStructures()).value, allStructuresResult);
  });

  test("test 2.2: get all structures exception on http request", () async {
    // Defining behaviour: throws error
    when(mockClient.get(getAllStructuresUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenThrow(new Exception());

    // testing
    expect((await accessDevices.getAllStructures()).isEmpty, true);
  });

  test(
      "test 2.3: get all structures returns response on http request in 200 ms",
      () async {
    // Defining behaviour: throws error
    when(mockClient.get(getAllStructuresUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    });
    when(mockResponse.body).thenReturn(allStructuresListResponse);

    // testing
    expect((await accessDevices.getAllStructures()).isEmpty, true);
  });

  test("test 3.1: get device status successful http request", () async {
    // Defining behaviour
    when(mockResponse.body).thenReturn(device1Response);

    // testing
    expect((await accessDevices.getDeviceStatus(device1Id)).value, "ONLINE");
  });

  test("test 3.2: get devices status exception on http request", () async {
    // Defining behaviour: throws error
    when(mockClient.get(getDevice1StatusUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenThrow(new Exception());

    // testing
    expect((await accessDevices.getDeviceStatus(device1Id)).isEmpty, true);
  });

  test(
      "test 3.3: get devices status returns response on http request in 200 ms",
      () async {
    // defining behaviour
    when(mockClient.get(getDevice1StatusUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    });
    when(mockResponse.body).thenReturn(device1Response);

    // testing
    expect((await accessDevices.getDeviceStatus(device1Id)).isEmpty, true);
  });

  test("test 4.1: get devices of structure successful http request", () async {
    // defining behaviour
    when(mockResponse.body).thenReturn(allDevicesListResponse);

    // testing
    expect((await accessDevices.getDevicesOfStructure(structure1Id)).value,
        devicesOfStructure1Result);
  });

  test("test 4.2: get devices of structure exception on http request",
      () async {
    // Defining behaviour: throws error
    when(mockClient.get(getAllDevicesUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenThrow(new Exception());

    // testing
    expect((await accessDevices.getDevicesOfStructure(structure1Id)).isEmpty,
        true);
  });

  test("test 4.3: get devices of structure timeout on http request", () async {
    // Defining behaviour: returns a response after 200 ms
    when(mockClient.get(getAllDevicesUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
        .thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    }); // Mock response returns a body
    when(mockResponse.body).thenReturn(allDevicesListResponse);

    // testing
    expect((await accessDevices.getDevicesOfStructure(structure1Id)).isEmpty,
        true);
  });
}
