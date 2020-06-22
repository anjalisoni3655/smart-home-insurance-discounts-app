import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:optional/optional.dart';
import 'dart:developer';

// Input: String of format: /key_1/value_1/key_2/value_2/../key_n/value_n. or key_1/value_1/key_2/value_2/../key_n/value_n
// Output: Map = {key_1: value_1, key_2: value_2, ..., key_n: value_n}
// Use case: to get enterprise id, structure id, device id, etc from assignee or name: enteprises/enterprise-id/structures/structure-id/... etc
Map<String, String> getId(String url) {
  //This regEx contains of any symbol or character except '/'
  RegExp pattern = new RegExp(r'[^//]+');
  Map <String,String> ids = {};
  //Find all substrings in url separated by '/'
  Iterable matches = pattern.allMatches(url);
  //  Iterate through all the matches and form key-valuuuue pair for adjacent elements in list .
  for(int i = 0 ; i < matches.length ; i+=2 ) {
    ids[matches.elementAt(i).group(0)] = matches.elementAt(i+1).group(0);
  }
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
        Map ids = getId(device['name']);
        devices.add({
          'id': ids['devices'],
          'customName': device['traits']['sdm.devices.traits.DeviceInfoTrait']
              ["customName"],
          'type': device['type'],
          'structureId': getId(device['assignee'])['structures']
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
      final response = await _client.get(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);

      var result = jsonDecode(response.body);
      List devices = [];
      for (var device in result['devices']) {
        if (getId(device['assignee'])['structures'] != structureId) continue;
        devices.add({
          'id': getId(device['name'])['devices'],
          'customName': device['traits']['sdm.devices.traits.DeviceInfoTrait']
              ["customName"],
          'type': device['type'],
          'structureId': getId(device['assignee'])['structures']
        });
      }
      return Optional.of(devices);
    } catch (error) {
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
