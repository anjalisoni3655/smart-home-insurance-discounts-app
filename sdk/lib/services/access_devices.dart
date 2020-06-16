import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:optional/optional.dart';
import 'dart:developer';

Map<String, String> getId(String name) {
  if (name[0] == '/') {
    name = name.substring(1);
  }
  Map<String, String> ids = {};
  bool flag = false;
  String key = '';
  String value = '';
  for (int i = 0; i < name.length; ++i) {
    if (name[i] == '/') {
      if (flag) {
        ids[key] = value;
        key = '';
        value = '';
        flag = false;
      } else {
        flag = true;
      }
    } else {
      if (flag) {
        value += name[i];
      } else {
        key += name[i];
      }
    }
  }
  ids[key] = value;
  return ids;
}

// Provides helper functions to get list of devices, structures, status of devices etc.
class AccessDevices {
  final String url;
  String _accessToken;
  String _refreshToken;
  String _enterpriseId;
  final Duration accessDevicesTimeoutDuration;
  http.Client _client;

  // Dependency Injection (constructor injection of http.Client service)
  AccessDevices(http.Client client, String enterpriseId,
      {this.accessDevicesTimeoutDuration = const Duration(seconds: 2),
      this.url =
          "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/"}) {
    this._enterpriseId = enterpriseId;
    _client = client;
  }

  void setCredentials(Map credentials) {
    this._accessToken = credentials['accessToken'];
    this._refreshToken = credentials['refreshToken'];
  }

  Future<Optional<List>> getAllDevices() async {
    if (_accessToken == null) {
      throw new Exception("Access Token not set");
    }
    try {
      String request = url + "enterprises/" + _enterpriseId + "/devices";
      final response = await _client.get(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      var result = jsonDecode(response.body);
      List devices = [];
      for (var device in result['devices']) {
        devices.add({
          'id': getId(device['name'])['devices'],
          'customName': device['traits']['sdm.devices.traits.DeviceInfoTrait']
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
    if (_accessToken == null) {
      throw new Exception("Access Token not set");
    }
    try {
      String request = url + "enterprises/" + _enterpriseId + "/devices";
      print(request);
      print(_accessToken);
      print(_client);
      final response = await _client.get(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      print(response.body);
      var result = jsonDecode(response.body);
      List devices = [];
      for (var device in result['devices']) {
        if (getId(device['assignee'])['structures'] != structureId) continue;
        devices.add({
          'id': getId(device['name'])['devices'],
          'customName': device['traits']['sdm.devices.traits.DeviceInfoTrait']
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
    if (_accessToken == null) {
      throw Exception("Access token not set");
    }
    try {
      String request = url + "enterprises/" + _enterpriseId + "/structures";
      final response = await _client.get(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      var result = jsonDecode(response.body);
      List structures = [];
      for (var structure in result['structures']) {
        structures.add({
          'id': getId(structure['name'])['structures'],
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
    if (_accessToken == null) {
      throw Exception("Access token not set");
    }
    try {
      String request =
          url + "enterprises/" + _enterpriseId + "/devices/" + deviceId;
      http.Response response = await _client.get(
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

  Future<void> refreshAccessToken() {
    // TODO: implement refreshing access token
  }
}
