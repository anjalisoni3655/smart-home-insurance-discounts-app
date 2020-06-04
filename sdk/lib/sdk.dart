library sdk;

import 'package:sdk/functionality/access_devices.dart';
import 'package:sdk/functionality/login.dart';
import 'package:sdk/functionality/resource_picker.dart';

class SDK {
  Login _login;
  ResourcePicker _resourcePicker;
  AccessDevices _accessDevices;

  Duration userInteractiveFlowTimeout;
  Duration nonUserInteractiveFlowTimeout;

  String clientId;
  String clientSecret;
  String enterpriseId;
  String redirectURL;

  SDK(String clientId, String clientSecret, String enterpriseId,
      String redirectURL,
      {this.userInteractiveFlowTimeout,
        this.nonUserInteractiveFlowTimeout}) {
    this.clientId = clientId;
    this.clientSecret = clientSecret;
    this.enterpriseId = enterpriseId;
    this.redirectURL = redirectURL;

    _login = new Login(
        userInteractiveFlowTimeout: userInteractiveFlowTimeout,
        nonUserInteractiveFlowTimeout: nonUserInteractiveFlowTimeout);
    _resourcePicker = new ResourcePicker(
        clientId, clientSecret, enterpriseId, redirectURL,
        resourcePickerTimeoutDuration: userInteractiveFlowTimeout);
  }

  Future<String> login() => _login.login();

  Future<String> logout() => _login.logout();

  Future<Map> getUserDetails() => _login.getUserDetails();

  Future<String> requestDeviceAccess() async {
    String status = await _resourcePicker.askForAuthorization();
    if (status == "authentication successful") {
      _accessDevices =
      new AccessDevices(_resourcePicker.accessToken, this.enterpriseId, accessDevicesTimeoutDuration: nonUserInteractiveFlowTimeout);
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
}
