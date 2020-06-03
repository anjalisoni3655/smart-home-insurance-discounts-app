import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sdk/functionality/resource_picker.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('test 1: ', () async {
    var clientSecret = jsonDecode(await rootBundle.loadString("/home/osheen/smart-home-insurance-discounts-app/sdk/client_secret.json"));
    ResourcePicker resourcePicker = new ResourcePicker(clientSecret["installed"]["client_id"], clientSecret["installed"]["client_secret"], clientSecret["installed"]["enterprise_id"], clientSecret["installed"]["redirect_uris"][0], testing: 1);
    expect(resourcePicker.resourcePickerURL, "https://accounts.google.com/o/oauth2/auth?client_id=482460250779-ttu9png19vnc3g0u7lr6cgi7vm8dh66m.apps.googleusercontent.com&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsdm.service&state=state");
    expect(await resourcePicker.askForAuthorization(), "authorization successful");
    expect(resourcePicker.accessToken, "accessTokenTest");
  });
}