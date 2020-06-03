library sdk;

import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis_auth/auth_io.dart';


class DeviceAccessAuthorization {
  String _accessToken;
  String _refreshToken;
  String _clientId;
  String _clientSecret;
  String _resourcePickerURL;
  List<String> _scope;

  DeviceAccessAuthorization(String clientId, String clientSecret, List<String> scope) {
    this._clientId = clientId;
    this._clientSecret = clientSecret;
    this._scope = scope;
  }

  Future<String> askForAuthorization() async {
    var authClient = await _launchResourcePicker(_resourcePickerURL);
    _accessToken = authClient.credentials.accessToken.data;
    _refreshToken = authClient.credentials.refreshToken.data;
  }

  Future<dynamic> _launchResourcePicker(String resourcePickerURL) async {
    var authClient = await clientViaUserConsent(
        ClientId(_clientId, _clientSecret), _scope, (url) {
      launch(url);
    });
    return authClient;
  }
  String get accessToken {
    return _accessToken;
  }
}