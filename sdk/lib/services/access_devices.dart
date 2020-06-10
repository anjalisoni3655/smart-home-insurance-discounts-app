import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:optional/optional.dart';

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
  static const String URL =
      "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/";

  String _accessToken;
  String _enterpriseId;
  final Duration accessDevicesTimeoutDuration;
  http.Client _client;

  // Dependency Injection (constructor injection of http.Client service)
  AccessDevices(http.Client client, String enterpriseId,
      {this.accessDevicesTimeoutDuration = const Duration(seconds: 2)}) {
    this._enterpriseId = enterpriseId;
    _client = client;
  }

  void setAccessToken(String accessToken) {
    print(accessToken);
    this._accessToken = accessToken;
  }

  Future<Optional<List>> getAllDevices() async {
    if (_accessToken == null) {
      throw new Exception("Access Token not set");
    }
    try {
      String request = URL + "enterprises/" + _enterpriseId + "/devices";
      final response = await _client.get(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      print(response.body);
      var result = jsonDecode(response.body);
      List devices = [];
      for (var device in result['devices']) {
        devices.add({
          'id': getId(device['name']),
          'customName': device['traits']['sdm.devices.traits.Info']["customName"],
          'type': device['type'],
        });
      }
      return Optional.of(devices);
    } catch (error) {
      print(error);
      return Optional.empty();
    }
  }

  Future<Optional<List>> getDevicesOfStructure(String structureId) async {
    if (_accessToken == null) {
      throw Exception("Access token not set");
    }
    try {
      String request = URL +
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
          'customName': device['traits']['sdm.devices.traits.Info'],
          'type': device['type'],
        });
      }
      return Optional.of(devices);
    } catch (error) {
      print(error);
      return Optional.empty();
    }
  }

  Future<Optional<List>> getAllStructures() async {
    if (_accessToken == null) {
      throw Exception("Access token not set");
    }
    try {
      String request = URL + "enterprises/" + _enterpriseId + "/structures";
      final response = await _client.post(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      var result = jsonDecode(response.body);
      List structures = [];
      for (var structure in result['structures']) {
        structures.add({
          'id': getId(structure['name']),
          'customName': structure['traits']['sdm.structures.traits.Info'],
        });
      }
      return Optional.of(structures);
    } catch (error) {
      print(error);
      return Optional.empty();
    }
  }

  Future<Optional<String>> getDeviceStatus(String deviceId) async {
    if (_accessToken == null) {
      throw Exception("Access token not set");
    }
    try {
      String request =
          URL + "enterprises/" + _enterpriseId + "/devices/" + deviceId;
      http.Response response = await _client.post(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      var result = jsonDecode(response.body);
      return Optional.of(result["traits"]
          ["sdm.devices.traits.DeviceConnectivityTrait"]["status"]);
    } catch (error) {
      print(error);
      return Optional.empty();
    }
  }
}
