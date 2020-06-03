library sdk;

import 'package:sdk/device_access_authorization.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


class AccessDevices {
  DeviceAccessAuthorization deviceAccessAuthorization;
  String enterpriseId;
  //TODO: Figure out how URL is added
  // $PCM_url/
  // $enterpriseid/auth?client_id=$_clientId&redirect_uri=$redirect_URL&response_type=code&scope=$Scopes&state=state

  String url;

  AccessDevices({this.deviceAccessAuthorization, this.enterpriseId});

  Future<List> getAllDevices() async {
    String accessToken = deviceAccessAuthorization.accessToken;
    final client = new http.Client();
    final response = await client.post(
      url + "enterprises/" + enterpriseId + "/devices",
      headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
    );
    // TODO: add return statement by appropriately  converting response
    final responseJson = json.decode(response.body);

    return responseJson['error'];
  }
}