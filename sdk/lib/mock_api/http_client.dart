import 'package:http/http.dart' as http;

class HttpClient {
  int testing;
  HttpClient({this.testing});

  Future<dynamic> post(String url, {Map<String, String> headers}) async {
    if(testing == 0) {
      var client = http.Client();
      return client.post(url, headers: headers);
    }
    else if(testing == 1) {
      return new MockResponse("list");
    }
    else if(testing == 2) {
      throw Exception();
    } else if(testing == 3) {
      await Future.delayed(new Duration(milliseconds: 200));
      return new MockResponse("list");
    }
  }
}

class MockResponse {
  String _body;
  MockResponse(String body) {
    this._body = body;
  }
  String get body => _body;
}