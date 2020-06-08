import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

// Provides the service of launching the resource picker and returning the access token obtained
class ResourcePicker {
  String _accessToken;
  String _refreshToken;
  String _clientId;
  String _clientSecret;
  String _resourcePickerURL;
  String _scope = "https://www.googleapis.com/auth/sdm.service";
  String _enterpriseId;
  String _pcmUrl = "https://accounts.google.com/o/oauth2";
  String _redirectURL;
  Duration resourcePickerTimeoutDuration;
  Function clientViaUserConsent;

  ResourcePicker(String clientId, String clientSecret, String enterpriseId,
      String redirectURL,
      {this.resourcePickerTimeoutDuration = const Duration(minutes: 5)}) {
    this.clientViaUserConsent = auth.clientViaUserConsent;
    this._clientId = clientId;
    this._clientSecret = clientSecret;
    this._enterpriseId = enterpriseId;
    this._redirectURL = redirectURL;
    _resourcePickerURL =
        "$_pcmUrl/auth?client_id=$_clientId&redirect_uri=$_redirectURL&response_type=code&scope=$_scope&state=state";
  }

  // Testing constructor
  ResourcePicker.test(String clientId, String clientSecret, String enterpriseId,
      String redirectURL, Function clientViaUserConsent,
      {this.resourcePickerTimeoutDuration = const Duration(minutes: 5)}) {
    this.clientViaUserConsent = clientViaUserConsent;
    this._clientId = clientId;
    this._clientSecret = clientSecret;
    this._enterpriseId = enterpriseId;
    this._redirectURL = redirectURL;
    _resourcePickerURL =
        "$_pcmUrl/auth?client_id=$_clientId&redirect_uri=$_redirectURL&response_type=code&scope=$_scope&state=state";
  }

  Future<String> askForAuthorization() async {
    // Launch URL for the resource picker and get back the access token that it returns
    try {
      var authClient = await _launchResourcePicker(_resourcePickerURL)
          .timeout(resourcePickerTimeoutDuration);
      _accessToken = authClient.credentials.accessToken.data;
      _refreshToken = authClient.credentials.refreshToken;
      return "authorization successful";
    } catch (error) {
      print(error);
      return "authorization failed";
    }
  }

  Future<dynamic> _launchResourcePicker(String resourcePickerURL) async {
    http.Client client = new http.Client();
    var authClient = await clientViaUserConsent(
        auth.ClientId(_clientId, _clientSecret), [_scope], (url) {launch(url);});
    print(authClient);
    return authClient;
  }

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  String get resourcePickerURL => _resourcePickerURL;
}
