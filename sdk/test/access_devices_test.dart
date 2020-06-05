import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sdk/services/access_devices.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

void main() {
  test("test 1: successful http request", () async {
    MockClient mockClient = new MockClient();
    MockResponse mockResponse = new MockResponse();

    // Defining behaviour: returns a mock response
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/devices",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenAnswer((_) => Future.value(mockResponse));
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/structures",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenAnswer((_) => Future.value(mockResponse));
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/devices/deviceId",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenAnswer((_) => Future.value(mockResponse));

    AccessDevices accessDevices =
        new AccessDevices.test("accessToken", "enterpriseId", mockClient);

    // Update behaviour: on call by getAllDevices the response should be
    when(mockResponse.body).thenReturn("list of devices");
    // Expected output
    expect(await accessDevices.getAllDevices(), "list of devices");
    // Update behaviour
    when(mockResponse.body).thenReturn("list of structures");
    // Expected output
    expect(await accessDevices.getAllStructures(), "list of structures");
    // Update behaviour
    when(mockResponse.body).thenReturn(
        '{"name" : "/enterprises/enterprise-id/devices/device-id","type" : "sdm.devices.types.device-type","traits" : {"sdm.devices.traits.DeviceConnectivityTrait" : {"status" : "ONLINE"}}}');
    // Expected output
    expect(await accessDevices.getDeviceStatus("deviceId"), "ONLINE");
  });

  test("test 2: http request throws an error", () async {
    MockClient mockClient = new MockClient();

    // Defining behaviour: returns a response
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/devices",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenThrow(new Exception());
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/structures",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenThrow(new Exception());
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/devices/deviceId",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenThrow(new Exception());

    AccessDevices accessDevices =
        new AccessDevices.test("accessToken", "enterpriseId", mockClient);

    // Expected output
    expect(await accessDevices.getAllDevices(), null);
    expect(await accessDevices.getAllStructures(), null);
    expect(await accessDevices.getDeviceStatus("deviceId"), null);
  });

  test("test 1: successful http request", () async {
    MockClient mockClient = new MockClient();
    MockResponse mockResponse = new MockResponse();

    // Defining behaviour: returns a response
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/devices",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    });
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/structures",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    });
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/devices/deviceId",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    });

    AccessDevices accessDevices = new AccessDevices.test(
        "accessToken", "enterpriseId", mockClient,
        accessDevicesTimeoutDuration: new Duration(milliseconds: 100));

    // Update behaviour
    when(mockResponse.body).thenReturn("list of devices");
    // Expected output
    expect(await accessDevices.getAllDevices(), null);
    // Update behaviour
    when(mockResponse.body).thenReturn("list of structures");
    // Expected output
    expect(await accessDevices.getAllStructures(), null);
    // Update behaviour
    when(mockResponse.body).thenReturn(
        '{"name" : "/enterprises/enterprise-id/devices/device-id","type" : "sdm.devices.types.device-type","traits" : {"sdm.devices.traits.DeviceConnectivityTrait" : {"status" : "ONLINE"}}}');
    // Expected output
    expect(await accessDevices.getDeviceStatus("deviceId"), null);
  });
}
