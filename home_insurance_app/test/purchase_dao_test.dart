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
  Offer offer1 = new Offer({'Camera': 1, 'Thermostat': 2}, 4);

  UserAddress userAddress1 = new UserAddress('firstLineOfAddress_1',
      'secondLineOfAddress_1', 'city_1', 'state_1', 123456);

  Purchase purchase1 = new Purchase(
      policy1, offer1, 'structure1Id', Timestamp.now(), userAddress1);

  String userId;

  setUp(() async {
    database = new MockFirestoreInstance();
    userId = (await database
            .collection('user')
            .add({'name': 'user1', 'email': 'user1@gmail.com'}))
        .documentID;
    purchaseDao = new PurchaseDao(database);
  });

  test('testing get Insurance and add Innsurance function', () async {
    List<Purchase> purchases = await purchaseDao.getInsurances(userId);
    expect(purchases.length, 0);

    await purchaseDao.addPurchase(userId, purchase1);

    purchases = await purchaseDao.getInsurances(userId);
    expect(purchases.length, 1);
    expect(purchases[0].policy.policyName, policy1.policyName);
    expect(purchases[0].policy.validity, policy1.validity);
    expect(purchases[0].policy.cost, policy1.cost);
    expect(purchases[0].offer.requirements, offer1.requirements);
    expect(purchases[0].offer.discount, offer1.discount);
    expect(purchases[0].address.firstLineOfAddress,
        userAddress1.firstLineOfAddress);
    expect(purchases[0].address.secondLineOfAddress,
        userAddress1.secondLineOfAddress);
    expect(purchases[0].address.city, userAddress1.city);
    expect(purchases[0].address.state, userAddress1.state);
    expect(purchases[0].address.pincode, userAddress1.pincode);
    expect(purchases[0].structureId, purchase1.structureId);
    expect(purchases[0].dateOfPurchase, purchase1.dateOfPurchase);
    expect(purchases[0].discountedCost, purchase1.discountedCost);
  });
}
