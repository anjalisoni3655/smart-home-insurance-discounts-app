import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:sdk/mock_api/googleapis_auth_io_api.dart';

class ResourcePicker {
  String _accessToken;
  String _refreshToken;
  String _clientId;
  String _clientSecret;
  String _resourcePickerURL;
  String _scope = "https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsdm.service";
  String _enterpriseId;
  String _pcmUrl = "https://accounts.google.com/o/oauth2";
  String _redirectURL;
  Duration resourcePickerTimeoutDuration;
  int testing;

  ResourcePicker(String clientId, String clientSecret, String enterpriseId,
      String redirectURL,
      {this.resourcePickerTimeoutDuration = const Duration(minutes: 5),
      this.testing = 0}) {
    this._clientId = clientId;
    this._clientSecret = clientSecret;
    this._enterpriseId = enterpriseId;
    this._redirectURL = redirectURL;
    _resourcePickerURL =
        "$_pcmUrl/auth?client_id=$_clientId&redirect_uri=$_redirectURL&response_type=code&scope=$_scope&state=state";
  }

  Future<String> askForAuthorization() async {
    try {
      var authClient = await _launchResourcePicker(_resourcePickerURL)
          .timeout(resourcePickerTimeoutDuration);
      _accessToken = authClient.credentials.accessToken.data;
      _refreshToken = authClient.credentials.refreshToken.data;
      return "authorization successful";
    } catch (error) {
      return "authorization failed";
    }
  }

  Future<dynamic> _launchResourcePicker(String resourcePickerURL) async {
    var authClient = await clientViaUserConsentAPI(
        ClientId(_clientId, _clientSecret), [_scope], (resourcePickerURL) {
      launch(resourcePickerURL);
    }, testing);
    return authClient;
  }

  String get accessToken => _accessToken;

  String get resourcePickerURL => _resourcePickerURL;
}
