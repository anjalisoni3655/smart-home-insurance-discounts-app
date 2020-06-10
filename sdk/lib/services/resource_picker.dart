import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

// Provides the service of launching the resource picker and returning the access token obtained
class ResourcePicker {
  String _accessToken;
  String _refreshToken;
  String _clientId;
  String _clientSecret;
  String _scope = "https://www.googleapis.com/auth/sdm.service";
  final Duration resourcePickerTimeoutDuration;
  Function clientViaUserConsent;

  // Dependency Injection (cunstructor injection of clientViaUserConsent service)
  ResourcePicker(
      Function clientViaUserConsent, String clientId, String clientSecret,
      {this.resourcePickerTimeoutDuration = const Duration(minutes: 5)}) {
    this.clientViaUserConsent = clientViaUserConsent;
    this._clientId = clientId;
    this._clientSecret = clientSecret;
  }

  Future<String> askForAuthorization() async {
    // Launch URL for the resource picker and get back the access token that it returns
    try {
      auth.AuthClient authClient = await clientViaUserConsent(
          auth.ClientId(_clientId, _clientSecret), [_scope], (url) {
        launch(url);
      }).timeout(resourcePickerTimeoutDuration);
      _accessToken = authClient.credentials.accessToken.data;
      _refreshToken = authClient.credentials.refreshToken;
      return "authorization successful";
    } catch (error) {
      print(error);
      return "authorization failed";
    }
  }

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
}
