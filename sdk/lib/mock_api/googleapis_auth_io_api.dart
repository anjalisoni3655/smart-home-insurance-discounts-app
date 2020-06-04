import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';

dynamic clientViaUserConsentAPI(
    ClientId clientId, List _scope, dynamic function, int testing) async {
  if (testing == 0) {
    dynamic authClient = clientViaUserConsent(clientId, _scope, function);
  } else if (testing == 1) {
    return AuthClientMock("accessTokenTest", "refreshTokenTest");
  } else if (testing == 2) {
    await Future.delayed(new Duration(milliseconds: 200));
  }
}

// Mocking AuthClient Class
class AccessTokenMock {
  String _data;

  AccessTokenMock(String accessToken) {
    _data = accessToken;
  }

  String get data => _data;
}

class Credentials {
  AccessTokenMock _accessToken;
  AccessTokenMock _refreshToken;

  Credentials(String accessToken, refreshToken) {
    _accessToken = new AccessTokenMock(accessToken);
    _refreshToken = new AccessTokenMock(refreshToken);
  }

  AccessTokenMock get accessToken => _accessToken;
  AccessTokenMock get refreshToken => _refreshToken;
}

class AuthClientMock {
  Credentials _credentials;

  AuthClientMock(String accessToken, refreshToken) {
    _credentials = new Credentials(accessToken, refreshToken);
  }

  Credentials get credentials => _credentials;
}
