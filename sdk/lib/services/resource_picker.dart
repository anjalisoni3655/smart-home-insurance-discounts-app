import 'dart:io';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis_auth/src/http_client_base.dart';

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
  ResourcePicker(
      Function clientViaUserConsent, String enterpriseId, String clientId, String clientSecret,
      {this.resourcePickerTimeoutDuration = const Duration(minutes: 5)}) {
    this.clientViaUserConsent = clientViaUserConsent;
    this._clientId = clientId;
    this._clientSecret = clientSecret;
    this._enterpriseId = enterpriseId;
  }

  Future<String> askForAuthorization() async {
    // Launch URL for the resource picker and get back the access token that it returns
    try {
      String domainName = "sdmresourcepicker-staging.sandbox.google.com/partnerconnections";
      var authClient = await auth.clientViaUserConsent(new auth.ClientId(_clientId, _clientSecret), [_scope], (url) {
        url = 'https://$domainName/$_enterpriseId' + url.substring(36) + '&access_type=offline';
        print(url);
        launch(url);
      });

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
