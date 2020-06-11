import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

// Provides the service of launching the resource picker and returning the access token obtained
class ResourcePicker {
  String _accessToken;
  String _refreshToken;
  String _enterpriseId;
  String _clientId;
  String _clientSecret;
  String _scope = "https://www.googleapis.com/auth/sdm.service";
  final Duration resourcePickerTimeoutDuration;
  Function clientViaUserConsent;

  // Dependency Injection (cunstructor injection of clientViaUserConsent service)
  ResourcePicker(Function clientViaUserConsent, String enterpriseId,
      String clientId, String clientSecret,
      {this.resourcePickerTimeoutDuration = const Duration(minutes: 5)}) {
    this.clientViaUserConsent = clientViaUserConsent;
    this._enterpriseId = enterpriseId;
    this._clientId = clientId;
    this._clientSecret = clientSecret;
  }

  Map getCredentials() => {"accessToken": _accessToken, "refreshTokennn": _refreshToken};

  Future<String> askForAuthorization() async {
    // Launch URL for the resource picker and get back the access token that it returns
    try {
      auth.AuthClient authClient = await clientViaUserConsent(
          auth.ClientId(_clientId, _clientSecret), [_scope], (url) {
        // remove the default 'https://accounts.google.com/o/oauth2' domain name by resource picker domain name
        url =
            'https://sdmresourcepicker-staging.sandbox.google.com/partnerconnections/$_enterpriseId' +
                url.substring(36);
        launch(url);
      }).timeout(resourcePickerTimeoutDuration);
      _accessToken = authClient.credentials.accessToken.data;
      _refreshToken = authClient.credentials.refreshToken;
      return "authorization successful";
    } catch (error) {
      log(error.toString());
      return "authorization failed";
    }
  }

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
}
