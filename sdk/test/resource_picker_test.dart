import 'package:flutter_test/flutter_test.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:mockito/mockito.dart';
import 'package:sdk/services/resource_picker.dart';

class MockAuthClient extends Mock implements AuthClient {}
class MockAccessCredentials extends Mock implements AccessCredentials {}
class MockAccessToken extends Mock implements AccessToken {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('test 1: API function returns AuthClient', () async {

    // Creating a mock AuthClient that gives an access token
    MockAuthClient mockAuthClient = new MockAuthClient();
    MockAccessCredentials mockAccessCredentials = new MockAccessCredentials();
    MockAccessToken mockAccessToken = new MockAccessToken();
    MockAccessToken mockRefreshToken = new MockAccessToken();

    when(mockAuthClient.credentials).thenReturn(mockAccessCredentials);
    when(mockAccessCredentials.accessToken).thenReturn(mockAccessToken);
    when(mockAccessCredentials.refreshToken).thenReturn("refreshTokenTest");
    when(mockAccessToken.data).thenReturn("accessTokenTest");

    // Defining the dummy function that will be passed on the resource picker to replace API call
    AuthClient mockClientViaUserConsent(ClientId clientId, List<String> scope, Function launchFunction()) {
      return mockAuthClient;
    }

    ResourcePicker resourcePicker = new ResourcePicker.test("client_id", "client_secret", "enterprise_id", "redirect_url", mockClientViaUserConsent);
    // Expected results:
    expect(resourcePicker.resourcePickerURL, "https://accounts.google.com/o/oauth2/auth?client_id=client_id&redirect_uri=redirect_url&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsdm.service&state=state");
    expect(await resourcePicker.askForAuthorization(), "authorization successful");
    expect(resourcePicker.accessToken, "accessTokenTest");
    expect(resourcePicker.refreshToken, "refreshTokenTest");
  });
  test('test 1: API function throws error', () async {
    MockAuthClient mockAuthClient = new MockAuthClient();
    MockAccessCredentials mockAccessCredentials = new MockAccessCredentials();
    MockAccessToken mockAccessToken = new MockAccessToken();
    MockAccessToken mockRefreshToken = new MockAccessToken();

    when(mockAuthClient.credentials).thenReturn(mockAccessCredentials);
    when(mockAccessCredentials.accessToken).thenReturn(mockAccessToken);
    when(mockAccessCredentials.refreshToken).thenReturn("refreshTokenTest");
    when(mockAccessToken.data).thenReturn("accessTokenTest");

    // Defining behaviour: throws an error on calling
    AuthClient mockClientViaUserConsent(ClientId clientId, List<String> scope, Function launchFunction()) {
      throw new Exception();
    }

    // Expected behaviour
    ResourcePicker resourcePicker = new ResourcePicker.test("client_id", "client_secret", "enterprise_id", "redirect_url", mockClientViaUserConsent);
    expect(resourcePicker.resourcePickerURL, "https://accounts.google.com/o/oauth2/auth?client_id=client_id&redirect_uri=redirect_url&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsdm.service&state=state");
    expect(await resourcePicker.askForAuthorization(), "authorization failed");
  });

}