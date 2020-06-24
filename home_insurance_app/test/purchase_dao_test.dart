import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/data/purchase.dart';
import 'package:homeinsuranceapp/data/purchase_dao.dart';
import 'package:homeinsuranceapp/data/user_home_details.dart';

void main() {
  MockFirestoreInstance database;
  PurchaseDao purchaseDao;

  Policy policy1 = new Policy('policy1Name', 6, 2000);
  Policy policy2 = new Policy('policy2Name', 5, 3000);
  Offer offer1 = new Offer({'Camera': 1, 'Thermostat': 2}, 4);
  Offer offer2 = new Offer({
    'Camera': 1,
  }, 2);
  UserAddress userAddress1 = new UserAddress('firstLineOfAddress_1',
      'secondLineOfAddress_1', 'city_1', 'state_1', 123456);
  UserAddress userAddress2 = new UserAddress('firstLineOfAddress_2',
      'secondLineOfAddress_2', 'city_2', 'state_2', 123456);

  Purchase purchase1 = new Purchase(
      policy1, offer1, 'structure1Id', Timestamp.now(), userAddress1);
  Purchase purchase2 = new Purchase(
      policy2, offer2, 'structure2Id', Timestamp.now(), userAddress2);

  String userId;

  setUp(() async {
    database = new MockFirestoreInstance();
    userId = (await database
            .collection('user')
            .add({'name': 'user1', 'email': 'user1@gmail.com'}))
        .documentID;
    purchaseDao = new PurchaseDao(database);
  });

  test('testing get policies function', () async {
    List<Purchase> purchases = await purchaseDao.getInsurances(userId);

    expect(purchases.length, 0);

    await purchaseDao.addPurchase(userId, purchase1);
  });
}
