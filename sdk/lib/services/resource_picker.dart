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

      HttpServer server = await HttpServer.bind('localhost', 0);

      var port = server.port;
      var redirectionUri = 'http://localhost:$port';
      var state = 'authcodestate${new DateTime.now().millisecondsSinceEpoch}';

      String resourcePickerUrl = 'https://$domainName/$_enterpriseId/auth?redirect_uri=$redirectionUri&access_type=offline&prompt=consent&client_id=$_clientId&response_type=code&state=$state&scope=https://www.googleapis.com/auth/sdm.service';
      launch(resourcePickerUrl);

      var request = await server.first;
      var uri = request.uri;

      var code = uri.queryParameters['code'];

      var uri2 = Uri.parse('https://accounts.google.com/o/oauth2/token');
      var formValues = [
        'grant_type=authorization_code',
        'code=${Uri.encodeQueryComponent(code)}',
        'redirect_uri=${Uri.encodeQueryComponent(redirectionUri)}',
        'client_id=${Uri.encodeQueryComponent(_clientId)}',
        'client_secret=${Uri.encodeQueryComponent(_clientSecret)}',
      ];

      var body = new Stream<List<int>>.fromIterable(
          <List<int>>[ascii.encode(formValues.join('&'))]);

      var request2 = new RequestImpl('POST', uri2, body);
      request2.headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';

      http.Client client = new http.Client();
      var response = await client.send(request2);
      request.response
        ..statusCode = 200
        ..headers.set('content-type', 'text/html; charset=UTF-8')
        ..write('''
<!DOCTYPE html>

<html>
  <head>
    <meta charset="utf-8">
    <title>Authorization successful.</title>
  </head>

  <body>
    <h2 style="text-align: center">Application has successfully obtained access credentials</h2>
    <p style="text-align: center">This window can be closed now.</p>
  </body>
</html>''');
      await request.response.close();

      Map jsonMap =
      await utf8.decoder.bind(response.stream).transform(json.decoder).first;

      _accessToken = jsonMap['access_token'];
      _refreshToken = jsonMap['refresh_token'];

      client.close();
      print(_accessToken);

      return "authorization successful";
    } catch (error) {
      print(error);
      return "authorization failed";
    }
  }

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
}
