library sdk;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:optional/optional.dart';
import 'package:sdk/services/access_devices.dart';
import 'package:sdk/services/login.dart';
import 'package:sdk/services/resource_picker.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:url_launcher/url_launcher.dart';

class SDK {
  Login _login;
  ResourcePicker _resourcePicker;
  AccessDevices _accessDevices;

  // Dependency injection (constructor injection of Login, ResourcePicker and AccessDevices services)
  SDK._(Login login, ResourcePicker resourcePicker,
      AccessDevices accessDevices) {
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

  Future<Map> getUserDetails() => _login.getUserDetails();

  Future<String> requestDeviceAccess() => _resourcePicker.askForAuthorization();


  Future<Optional<String>> getAllDevices() => _accessDevices.getAllDevices();

  Future<Optional<String>> getAllStructures() =>
      _accessDevices.getAllStructures();

  Future<Optional<String>> getDeviceStatus(String deviceId) =>
      _accessDevices.getDeviceStatus(deviceId);
}

// Builder and Injector class that creates dependancies and injects them into the SDK
// Creating an instance of SDK without builder is not allowed.
class SDKBuilder {
  static SDK build(String clientId, String clientSecret, String enterpriseId,
      {Duration interactiveFlowTimeout = const Duration(minutes: 5),
        Duration nonInteractiveFlowTimout = const Duration(seconds: 1)}) {
    Login login = new Login(GoogleSignIn(), interactiveFlowTimeout: interactiveFlowTimeout, nonInteractiveFlowTimeout: nonInteractiveFlowTimout);
    ResourcePicker resourcePicker = new ResourcePicker(auth.clientViaUserConsent, clientId, clientSecret, resourcePickerTimeoutDuration: interactiveFlowTimeout);
    AccessDevices accessDevices = new AccessDevices(http.Client(), enterpriseId);

    SDK sdk = new SDK._(login, resourcePicker, accessDevices);
    return sdk;
  }
}