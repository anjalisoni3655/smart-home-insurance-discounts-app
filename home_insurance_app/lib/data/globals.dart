library globals;

import 'package:sdk/sdk.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<SDK> initialiseSDK({test = false}) async {
  String _clientId;
  String _clientSecret;
  String _enterpriseId;
  if(test) {
    _clientId = 'clientId';
    _clientSecret = 'clientSecret';
    _enterpriseId = 'enterpriseId';
  } else {
    final RemoteConfig _remoteConfig = await RemoteConfig.instance;
    await _remoteConfig.fetch();
    await _remoteConfig.activateFetched();
    _clientId = _remoteConfig.getString('client_id');
    _clientSecret = _remoteConfig.getString('client_secret');
    _enterpriseId = _remoteConfig.getString('enterprise_id');
  }
  SDK sdk = SDKBuilder.build(_clientId, _clientSecret, _enterpriseId,
      testing: test,
      nonInteractiveFlowTimout: const Duration(seconds: 10),
      interactiveFlowTimeout: const Duration(minutes: 5));
  return sdk;
}

SDK sdk;
