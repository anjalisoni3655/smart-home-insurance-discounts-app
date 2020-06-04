library sdk;

import 'dart:io';
import 'package:http/http.dart' as http;

class HttpClient {
  int testing;
  HttpClient({this.testing});

  Future<dynamic> post(String url, {Map<String, String> headers}) async {
    if (testing == 0) {
      var client = http.Client();
      return client.post(url, headers: headers);
    } else if (testing == 1) {
      if (headers[HttpHeaders.authorizationHeader] != "Bearer accessToken") {
        throw Exception("incorrect headers");
      }
      if (url ==
          "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/devices") {
        return new MockResponse("list of devices");
      } else if (url ==
          "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/structures") {
        return new MockResponse("list of structures");
      } else if (url ==
          "https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/enterpriseId/devices/deviceId") {
        return new MockResponse(
            '{"name" : "/enterprises/enterprise-id/devices/device-id","type" : "sdm.devices.types.device-type","traits" : {"sdm.devices.traits.DeviceConnectivityTrait" : {"status" : "ONLINE"}}}');
      }
      throw Exception("incorrect url");
    } else if (testing == 2) {
      throw Exception();
    } else if (testing == 3) {
      await Future.delayed(new Duration(milliseconds: 200));
      return new MockResponse("list");
    }
  }
}

class MockResponse {
  String _body;
  MockResponse(String body) {
    this._body = body;
  }
  String get body => _body;
}
