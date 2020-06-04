library sdk;

import 'dart:convert';
import 'dart:io';
import 'package:sdk/mock_api/http_client.dart';

class AccessDevices {
  static const String URL = "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/";

  String _accessToken;
  String _enterpriseId;
  int testing;
  Duration accessDevicesTimeoutDuration;

  AccessDevices(String accessToken, String enterpriseId, {this.testing, this.accessDevicesTimeoutDuration = const Duration(seconds: 2)}) {
    this._accessToken = accessToken;
    this._enterpriseId = enterpriseId;
  }

  Future<dynamic> getAllDevices() async {
    try {
      final client = new HttpClient(testing: testing);
      final response = await client.post(
        URL + "enterprises/" + _enterpriseId + "/devices",
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      // TODO: convert response body to list of devices, can be done once format of response is known
      return response.body;
    } catch (error) {
      return null;
    }
  }
  Future<dynamic> getAllStructures() async {
    try {
      final client = new HttpClient(testing: testing);
      final response = await client.post(
        URL + "enterprises/" + _enterpriseId + "/structures",
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      // TODO: convert response body to list of structures, can be done once format of response is known
      return response.body;
    } catch (error) {
      return null;
    }
  }
  Future<dynamic> getDeviceStatus(String deviceId) async {
    try {
      final client = new HttpClient(testing: testing);
      var response = await client.post(
        URL + "enterprises/" + _enterpriseId + "/devices/" + deviceId,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'},
      ).timeout(accessDevicesTimeoutDuration);
      response = jsonDecode(response.body);
      return response["traits"]["sdm.devices.traits.DeviceConnectivityTrait"]["status"];
    } catch (error) {
      return null;
    }
  }


}