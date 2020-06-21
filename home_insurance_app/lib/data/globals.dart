library globals;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeinsuranceapp/data/offer_dao.dart';
import 'package:homeinsuranceapp/data/policy_dao.dart';
import 'package:homeinsuranceapp/data/purchase_dao.dart';
import 'package:optional/optional.dart';
import 'package:sdk/sdk.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<void> initialise({test = false}) async {
  String _clientId;
  String _clientSecret;
  String _enterpriseId;
  if (test) {
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
  sdk = SDKBuilder.build(_clientId, _clientSecret, _enterpriseId,
      testing: test,
      nonInteractiveFlowTimout: const Duration(seconds: 10),
      interactiveFlowTimeout: const Duration(minutes: 5));

  policyDao = new PolicyDao(Firestore.instance);
  offerDao = new OfferDao(Firestore.instance);
  purchaseDao = new PurchaseDao(Firestore.instance);
}

SDK sdk;
OfferDao offerDao;
PolicyDao policyDao;
PurchaseDao purchaseDao;

class User {
  String displayName;
  String photoUrl;
  String email; 
  String userId;


}

User user = User();

Optional<List> devices = Optional.empty();
