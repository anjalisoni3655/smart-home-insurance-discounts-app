import 'package:flutter_test/flutter_test.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:mockito/mockito.dart';
import 'package:sdk/services/resource_picker.dart';

import 'login_test.dart';

class MockAuthClient extends Mock implements AuthClient {}

class MockAccessCredentials extends Mock implements AccessCredentials {}

class MockAccessToken extends Mock implements AccessToken {}

MockAuthClient mockAuthClient;
MockAccessCredentials mockAccessCredentials;
MockAccessToken mockAccessToken;
MockAccessToken mockRefreshToken;

// setup the mock objects

void main() {
  // Set up initialising mock objects

  setUp(() {
    mockAuthClient = new MockAuthClient();
    mockAccessCredentials = new MockAccessCredentials();
    mockAccessToken = new MockAccessToken();
    mockRefreshToken = new MockAccessToken();

    when(mockAuthClient.credentials).thenReturn(mockAccessCredentials);
    when(mockAccessCredentials.accessToken).thenReturn(mockAccessToken);
    when(mockAccessCredentials.refreshToken).thenReturn("refreshTokenTest");
    when(mockAccessToken.data).thenReturn("accessTokenTest");
  });

  test('test 1: API function returns AuthClient', () async {
    // Creating a mock AuthClient that gives an access token
    // Defining the dummy function that will be passed on the resource picker to replace API call
    Future<AuthClient> mockClientViaUserConsent(ClientId clientId,
        List<String> scope, void launchFunction(String url)) async {
      return mockAuthClient;
    }

    ResourcePicker resourcePicker = new ResourcePicker.test(
        "client_id", "client_secret", mockClientViaUserConsent);
    // Expected results:
    expect(
        await resourcePicker.askForAuthorization(), "authorization successful");
    expect(resourcePicker.accessToken, "accessTokenTest");
    expect(resourcePicker.refreshToken, "refreshTokenTest");
  });
  test('test 2: API function throws error', () async {
    // Defining behaviour: throws an error on calling
    AuthClient mockClientViaUserConsent(
        ClientId clientId, List<String> scope, Function launchFunction) {
      throw new Exception();
    }

    // Expected behaviour
    ResourcePicker resourcePicker = new ResourcePicker.test(
        "client_id", "client_secret", mockClientViaUserConsent);
    expect(await resourcePicker.askForAuthorization(), "authorization failed");
  });

  test('test 3: API function takes longer than timeout set', () async {
    // Defining behaviour: throws an error on calling
    Future<AuthClient> mockClientViaUserConsent(
        ClientId clientId, List<String> scope, Function launchFunction) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return mockAuthClient;
    }

    // Expected behaviour
    ResourcePicker resourcePicker = new ResourcePicker.test(
        "client_id", "client_secret", mockClientViaUserConsent,
        resourcePickerTimeoutDuration: new Duration(milliseconds: 100));
    expect(await resourcePicker.askForAuthorization(), "authorization failed");
  });
}
