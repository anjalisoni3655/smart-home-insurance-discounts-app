import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:optional/optional.dart';

// Provides helper functions to get list of devices, structures, status of devices etc.
class AccessDevices {
  static const String URL =
      "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/";

  String _accessToken;
  String _enterpriseId;
  final Duration accessDevicesTimeoutDuration;
  http.Client _client;

  // Dependency Injection (constructor injection of http.Client service)
  AccessDevices( http.Client client, String enterpriseId,
      {this.accessDevicesTimeoutDuration = const Duration(seconds: 2)}) {
    this._enterpriseId = enterpriseId;
    _client = client;
  }

  void setAccessToken(String accessToken) {
    this._accessToken = accessToken;
  }

  Future<Optional<String>> getAllDevices() async {
    if(_accessToken == null) {
      throw Exception("Access Token not set");
    }
    try {
      String request = URL + "enterprises/" + _enterpriseId + "/devices";
      final response = await _client.post(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      // TODO: convert response body to list of devices, can be done once format of response is known
      return Optional.of(response.body);
    } catch (error) {
      return Optional.empty();
    }
  }

  Future<Optional<String>> getAllStructures() async {
    if(_accessToken == null) {
      throw Exception("Access Token not set");
    }
    try {
      String request = URL + "enterprises/" + _enterpriseId + "/structures";
      final response = await _client.post(
        request,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      // TODO: convert response body to list of structures, can be done once format of response is known
      return Optional.of(response.body);
    } catch (error) {
      return Optional.empty();
    }
  }

  Future<Optional<String>> getDeviceStatus(String deviceId) async {
    if(_accessToken == null) {
      throw Exception("Access Token not set");
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
      return Optional.empty();
    }
  }
}
