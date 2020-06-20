import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockAuthClient extends Mock implements AuthClient {}

class MockAccessCredentials extends Mock implements AccessCredentials {}

class MockAccessToken extends Mock implements AccessToken {}

class MockClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class MockApis {
  // returns a mock object for googleSignIn API
  static get googleSignIn {
    MockGoogleSignIn mockGoogleSignIn = new MockGoogleSignIn();
    MockGoogleSignInAccount mockGoogleSignInAccount =
        new MockGoogleSignInAccount();

    // Describing behaviour of mock google sign in
    when(mockGoogleSignIn.signIn()).thenAnswer((_) {
      when(mockGoogleSignIn.isSignedIn()).thenAnswer((_) => Future.value(true));
      return Future.value(mockGoogleSignInAccount);
    });
    when(mockGoogleSignIn.signOut()).thenAnswer((_) {
      when(mockGoogleSignIn.isSignedIn())
          .thenAnswer((_) => Future.value(false));
      return Future.value(mockGoogleSignInAccount);
    });
    when(mockGoogleSignIn.currentUser).thenReturn(mockGoogleSignInAccount);

    // The account should return the following dummy details
    when(mockGoogleSignInAccount.displayName).thenReturn("Osheen Sachdev");
    when(mockGoogleSignInAccount.email).thenReturn("osheen@google.com");
    when(mockGoogleSignInAccount.photoUrl).thenReturn(
        "https://www.kindpng.com/picc/m/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png");
    when(mockGoogleSignIn.isSignedIn()).thenAnswer((_) => Future.value(false));

    return mockGoogleSignIn;
  }

  // returns a mock function to authenticate user
  static get clientViaUserConsent =>
      (ClientId clientId, List<String> scopes, Function userPrompt) async {
        MockAuthClient mockAuthClient = new MockAuthClient();
        MockAccessCredentials mockAccessCredentials =
            new MockAccessCredentials();
        MockAccessToken mockAccessToken = new MockAccessToken();

        when(mockAuthClient.credentials).thenReturn(mockAccessCredentials);
        when(mockAccessCredentials.accessToken).thenReturn(mockAccessToken);
        when(mockAccessCredentials.refreshToken).thenReturn("refreshToken");
        when(mockAccessToken.data).thenReturn("accessToken");
        return Future.value(mockAuthClient);
      };

  // returns a mock http client
  static get client {
    MockClient mockClient = new MockClient();
    MockResponse mockResponse = new MockResponse();

    defineResponse(mockClient, mockResponse);
    return mockClient;
  }
}

void defineResponse(MockClient mockClient, MockResponse mockResponse) {
  // Naming enterprises, structures and devices
  const url =
      'https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/';
  const enterpriseId = 'enterpriseId';
  const structure1Id = 'home-1-structure-id';
  const structure1Name = 'home-1';
  const structure2Id = 'home-2-structure-id';
  const structure2Name = 'home-2';
  const device1Id = 'device-1-device-id';
  const device1Name = 'device-1-name';
  const device1Type = "sdm.devices.types.THERMOSTAT";
  const device2Id = 'device-2-device-id';
  const device2Name = 'device-2-name';
  const device2Type = "sdm.devices.types.CAMERA";

  // Valid GET Request URLs
  const String getAllDevicesUrl = "${url}enterprises/$enterpriseId/devices";
  const String getAllStructuresUrl =
      "${url}enterprises/$enterpriseId/structures";
  const String getDevice1StatusUrl =
      "${url}enterprises/$enterpriseId/devices/$device1Id";

  // Responses returned by the SDM API
  const device1Response =
      '{"name" : "/enterprises/$enterpriseId/devices/$device1Id","type" : "$device1Type", "assignee": "/enterprises/$enterpriseId/structures/$structure1Id","traits" : {"sdm.devices.traits.DeviceConnectivityTrait" : {"status" : "ONLINE"}, "sdm.devices.traits.DeviceInfoTrait": {"customName": "$device1Name"}}}';
  const device2Response =
      '{"name" : "/enterprises/$enterpriseId/devices/$device2Id","type" : "$device2Type", "assignee": "/enterprises/$enterpriseId/structures/$structure2Id","traits" : {"sdm.devices.traits.DeviceConnectivityTrait" : {"status" : "OFFLINE"}, "sdm.devices.traits.DeviceInfoTrait": {"customName": "$device2Name"}}}';
  const allDevicesListResponse =
      '{ "devices": [$device1Response, $device2Response] }';
  const structure1Response =
      '{"name": "enterprises/$enterpriseId/structures/$structure1Id","traits": {"sdm.structures.traits.Info": {"customName": "$structure1Name"}}}';
  const structure2Response =
      '{"name": "enterprises/$enterpriseId/structures/$structure2Id","traits": {"sdm.structures.traits.Info": {"customName": "$structure2Name"}}}';
  const allStructuresListResponse =
      '{ "structures": [$structure1Response, $structure2Response] }';

  when(mockClient.get(getAllDevicesUrl,
          headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
      .thenAnswer((_) {
    when(mockResponse.body).thenReturn(allDevicesListResponse);
    return Future.value(mockResponse);
  });
  when(mockClient.get(getAllStructuresUrl,
          headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
      .thenAnswer((_) {
    when(mockResponse.body).thenReturn(allStructuresListResponse);
    return Future.value(mockResponse);
  });
  when(mockClient.get(getDevice1StatusUrl,
          headers: {HttpHeaders.authorizationHeader: "Bearer accessToken"}))
      .thenAnswer((_) {
    when(mockResponse.body).thenReturn(device1Response);
    return Future.value(mockResponse);
  });
}
