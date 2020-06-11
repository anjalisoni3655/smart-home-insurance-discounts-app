library sdk;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:optional/optional.dart';
import 'dart:developer';

String getId(String name) {
  String deviceId = '';
  for (int i = 0; i < name.length; ++i) {
    if (name[i] == '/') {
      deviceId = '';
    } else {
      deviceId += name[i];
    }
  }
  return deviceId;
}

// Provides helper functions to get list of devices, structures, status of devices etc.
class AccessDevices {
  final String url;

  String _accessToken;
  String _enterpriseId;
  final Duration accessDevicesTimeoutDuration;
  http.Client _client;

  AccessDevices(String accessToken, String enterpriseId,
      {this.accessDevicesTimeoutDuration = const Duration(seconds: 2),
      this.url = "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/"}) {
    this._accessToken = accessToken;
    this._enterpriseId = enterpriseId;
    _client = new http.Client();
  }

  AccessDevices.test(
      String accessToken, String enterpriseId, http.Client client,
      {this.accessDevicesTimeoutDuration = const Duration(seconds: 2),
        this.url = "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/"}) {
    this._accessToken = accessToken;
    this._enterpriseId = enterpriseId;
    _client = client;
  }

  Future<Optional<List>> getAllDevices() async {
    try {
      String request = url + "enterprises/" + _enterpriseId + "/devices";
      final response = await _client.post(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      var result = jsonDecode(response.body);
      List devices = [];
      for (var device in result['devices']) {
        devices.add({
          'id': getId(device['name']),
          'customName': device['traits']['sdm.devices.traits.Info']
              ["customName"],
          'type': device['type'],
        });
      }
      return Optional.of(devices);
    } catch (error) {
      log(error.toString());
      return Optional.empty();
    }
  }

  Future<Optional<List>> getDevicesOfStructure(String structureId) async {
    try {
      String request = url +
          "enterprises/" +
          _enterpriseId +
          '/structures/' +
          structureId +
          "/devices";
      final response = await _client.post(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      var result = jsonDecode(response.body);
      List devices = [];
      for (var device in result['devices']) {
        devices.add({
          'id': getId(device['name']),
          'customName': device['traits']['sdm.devices.traits.Info']
              ["customName"],
          'type': device['type'],
        });
      }
      return Optional.of(devices);
    } catch (error) {
      log(error.toString());
      return Optional.empty();
    }
  }

  Future<Optional<List>> getAllStructures() async {
    try {
      String request = url + "enterprises/" + _enterpriseId + "/structures";
      final response = await _client.post(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      var result = jsonDecode(response.body);
      List structures = [];
      for (var structure in result['structures']) {
        structures.add({
          'id': getId(structure['name']),
          'customName': structure['traits']['sdm.structures.traits.Info']
              ["customName"],
        });
      }
      return Optional.of(structures);
    } catch (error) {
      log(error.toString());
      return Optional.empty();
    }
  }

  Future<Optional<String>> getDeviceStatus(String deviceId) async {
    try {
      String request =
          url + "enterprises/" + _enterpriseId + "/devices/" + deviceId;
      http.Response response = await _client.post(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      var result = jsonDecode(response.body);
      return Optional.of(result["traits"]
          ["sdm.devices.traits.DeviceConnectivityTrait"]["status"]);
    } catch (error) {
      log(error.toString());
      return Optional.empty();
    }
  }
}
