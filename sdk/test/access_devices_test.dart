import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sdk/services/access_devices.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

MockClient mockClient;
MockResponse mockResponse;

void main() {
  // Default setup
  setUp(() {
    mockClient = new MockClient();
    mockResponse = new MockResponse();
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
  });

  test("test 1.1: get all devices successful http request", () async {
    AccessDevices accessDevices =
        new AccessDevices.test("accessToken", "enterpriseId", mockClient);
    when(mockResponse.body).thenReturn("list of devices");
    expect(await accessDevices.getAllDevices(), "list of devices");
  });

  test("test 1.2: get all devices exception on http request", () async {
    // Defining behaviour: throws error
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/devices",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenThrow(new Exception());
    AccessDevices accessDevices =
        new AccessDevices.test("accessToken", "enterpriseId", mockClient);
    expect(await accessDevices.getAllDevices(), null);
  });

  test("test 1.3: get all devices timeout on http request", () async {
    // Defining behaviour: returns a response after 200 ms
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/devices",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    }); // Mock response returns a body
    when(mockResponse.body).thenReturn("list of devices");

    AccessDevices accessDevices = new AccessDevices.test(
        "accessToken", "enterpriseId", mockClient,
        accessDevicesTimeoutDuration: new Duration(milliseconds: 100));

    expect(await accessDevices.getAllDevices(), null);
  });

  test("test 2.1: get all structures successful http request", () async {
    AccessDevices accessDevices =
        new AccessDevices.test("accessToken", "enterpriseId", mockClient);
    when(mockResponse.body).thenReturn("list of structures");
    expect(await accessDevices.getAllStructures(), "list of structures");
  });

  test("test 2.2: get all structures exception on http request", () async {
    // Defining behaviour: throws error
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/structures",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenThrow(new Exception());
    AccessDevices accessDevices =
        new AccessDevices.test("accessToken", "enterpriseId", mockClient);
    expect(await accessDevices.getAllStructures(), null);
  });

  test(
      "test 2.3: get all structures returns response on http request in 200 ms",
      () async {
    // Defining behaviour: throws error
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/structures",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    });
    when(mockResponse.body).thenReturn("list of structures");
    AccessDevices accessDevices = new AccessDevices.test(
        "accessToken", "enterpriseId", mockClient,
        accessDevicesTimeoutDuration: new Duration(milliseconds: 100));
    expect(await accessDevices.getAllStructures(), null);
  });

  test("test 3.1: get device status successful http request", () async {
    AccessDevices accessDevices =
        new AccessDevices.test("accessToken", "enterpriseId", mockClient);
    when(mockResponse.body).thenReturn(
        '{"name" : "/enterprises/enterprise-id/devices/device-id","type" : "sdm.devices.types.device-type","traits" : {"sdm.devices.traits.DeviceConnectivityTrait" : {"status" : "ONLINE"}}}');
    // Expected output
    expect(await accessDevices.getDeviceStatus("deviceId"), "ONLINE");
  });

  test("test 3.2: get devices status exception on http request", () async {
    // Defining behaviour: throws error
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/devices/deviceId",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenThrow(new Exception());
    AccessDevices accessDevices =
        new AccessDevices.test("accessToken", "enterpriseId", mockClient);
    expect(await accessDevices.getDeviceStatus("deviceId"), null);
  });

  test(
      "test 3.3: get devices status returns response on http request in 200 ms",
      () async {
    when(mockClient.post(
        "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/devices/deviceId",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer accessToken"
        })).thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return Future.value(mockResponse);
    });
    when(mockResponse.body).thenReturn(
        '{"name" : "/enterprises/enterprise-id/devices/device-id","type" : "sdm.devices.types.device-type","traits" : {"sdm.devices.traits.DeviceConnectivityTrait" : {"status" : "ONLINE"}}}');

    AccessDevices accessDevices = new AccessDevices.test(
        "accessToken", "enterpriseId", mockClient,
        accessDevicesTimeoutDuration: new Duration(milliseconds: 100));
    expect(await accessDevices.getDeviceStatus("deviceId"), null);
  });
}
