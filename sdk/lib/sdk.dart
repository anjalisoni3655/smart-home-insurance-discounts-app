library sdk;

import 'package:sdk/functionality/access_devices.dart';
import 'package:sdk/functionality/login.dart';
import 'package:sdk/functionality/resource_picker.dart';
import 'package:sdk/User.dart';
import 'package:url_launcher/url_launcher.dart';

class SDK {
  Login _login;
  ResourcePicker _resourcePicker;
  AccessDevices _accessDevices;

  Duration loginTimeoutDuration;
  Duration logoutTimeoutDuration;
  Duration isSignedInTimeoutDuration;
  Duration resourcePickerTimeoutDuration;
  Duration accessDevicesTimeoutDuration;

  String clientId;
  String clientSecret;
  String enterpriseId;
  String redirectURL;

  SDK(String clientId, String clientSecret, String enterpriseId,
      String redirectURL,
      {this.loginTimeoutDuration,
      this.logoutTimeoutDuration,
      this.isSignedInTimeoutDuration,
      this.resourcePickerTimeoutDuration}) {
    this.clientId = clientId;
    this.clientSecret = clientSecret;
    this.enterpriseId = enterpriseId;
    this.redirectURL = redirectURL;

    _login = new Login(
        logoutTimeoutDuration: logoutTimeoutDuration,
        loginTimeoutDuration: loginTimeoutDuration,
        isSignedInTimeoutDuration: isSignedInTimeoutDuration);
    _resourcePicker = new ResourcePicker(
        clientId, clientSecret, enterpriseId, redirectURL,
        resourcePickerTimeoutDuration: resourcePickerTimeoutDuration);
  }

  Future<String> login() => _login.login();
  Future<String> logout() => _login.logout();
  Future<User> getUserDetails() => _login.getUserDetails();

  Future<String> requestDeviceAccess() async {
    String status = await _resourcePicker.askForAuthorization();
    if (status == "authentication successful") {
      _accessDevices =
          new AccessDevices(_resourcePicker.accessToken, this.enterpriseId);
    }
    return status;
  }

  Future<String> getAllDevices() async {
    if (_accessDevices == null) {
      return null;
    } else {
      return await _accessDevices.getAllDevices();
    }
  }

  Future<String> getAllStructures() async {
    if (_accessDevices == null) {
      return null;
    } else {
      return await _accessDevices.getAllStructures();
    }
  }

  Future<String> getDeviceStatus(String deviceId) async {
    if (_accessDevices == null) {
      return null;
    } else {
      return await _accessDevices.getDeviceStatus(deviceId);
    }
  }

  void myDevices() {
    launch("https://nestservices.google.com/partnerconnections");
  }
}
