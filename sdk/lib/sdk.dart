library sdk;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:optional/optional.dart';
import 'package:sdk/integration_test/mock_apis.dart';
import 'package:sdk/services/access_devices.dart';
import 'package:sdk/services/login.dart';
import 'package:sdk/services/resource_picker.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

// The main SDK class the user will access
class SDK {
  Login _login;
  ResourcePicker _resourcePicker;
  AccessDevices _accessDevices;

  // Dependency injection (constructor injection of Login, ResourcePicker and AccessDevices services)
  SDK._(
      Login login, ResourcePicker resourcePicker, AccessDevices accessDevices) {
    if (login == null || resourcePicker == null || accessDevices == null) {
      throw new Exception("Parameters passed can't be null");
    } else {
      this._login = login;
      this._resourcePicker = resourcePicker;
      this._accessDevices = accessDevices;
    }
  }

  Future<String> login() => _login.login();
  Future<String> logout() => _login.logout();
  Future<Optional<Map>> getUserDetails() => _login.getUserDetails();
  Future<Optional<bool>> isSignedIn() => _login.isSignedIn();

  Future<String> requestDeviceAccess() async {
    String status = await _resourcePicker.askForAuthorization();
    if (status == 'authorization successful') {
      setCredentials(getCredentials());
    }
    return status;
  }

  Map getCredentials() => _resourcePicker.getCredentials();

  void setCredentials(credentials) =>
      _accessDevices.setCredentials(credentials);
  Future<Optional<List>> getAllDevices() => _accessDevices.getAllDevices();
  Future<Optional<List>> getDevicesOfStructure(String structureId) =>
      _accessDevices.getDevicesOfStructure(structureId);
  Future<Optional<List>> getAllStructures() =>
      _accessDevices.getAllStructures();
  Future<Optional<String>> getDeviceStatus(String deviceId) =>
      _accessDevices.getDeviceStatus(deviceId);
}

// Builder and Injector class that creates dependancies and injects them into the SDK
// Creating an instance of SDK without builder is not allowed.
class SDKBuilder {
  static SDK build(String clientId, String clientSecret, String enterpriseId,
      {Duration interactiveFlowTimeout = const Duration(minutes: 5),
      Duration nonInteractiveFlowTimout = const Duration(seconds: 1),
      testing = false}) {
    // External APIs
    GoogleSignIn googleSignIn;
    Function clientViaUserConsent;
    http.Client client;

    // Assigning external API as mock or real
    if (testing) {
      googleSignIn = MockApis.googleSignIn;
      clientViaUserConsent = MockApis.clientViaUserConsent;
      client = MockApis.client;
    } else {
      googleSignIn = new GoogleSignIn();
      clientViaUserConsent = auth.clientViaUserConsent;
      client = new http.Client();
    }

    // inject API into login, resourcePicker, accessDevices
    Login login = new Login(googleSignIn,
        interactiveFlowTimeout: interactiveFlowTimeout,
        nonInteractiveFlowTimeout: nonInteractiveFlowTimout);
    ResourcePicker resourcePicker = new ResourcePicker(
        clientViaUserConsent, enterpriseId, clientId, clientSecret,
        resourcePickerTimeoutDuration: interactiveFlowTimeout);
    AccessDevices accessDevices = new AccessDevices(client, enterpriseId,
        accessDevicesTimeoutDuration: nonInteractiveFlowTimout);

    // inject login, resourcePicker, accessDevices into sdk
    SDK sdk = new SDK._(login, resourcePicker, accessDevices);
    return sdk;
  }
}
