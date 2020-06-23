import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/data/policy_dao.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';

void main() {
  MockFirestoreInstance database;
  PolicyDao policyDao;
  const int pincode = 123456;
  const int category = pincode % 3 + 1;

  Policy policy1 = new Policy("FLood Insurance", 6, 2000);
  Policy policy2 = new Policy("Fire Insurance", 5, 3000);
  Policy policy3 = new Policy("Theft Insurance", 7, 4000);

  setUp(() {
    database = new MockFirestoreInstance();
    database.collection('policy').add({
      "name": policy1.policyName,
      "category": category,
      "cost": policy1.cost,
      "validity": policy1.validity,
      "deactivated": false
    });
    database.collection('policy').add({
      "name": policy2.policyName,
      "category": category,
      "cost": policy2.cost,
      "validity": policy2.validity,
      "deactivated": true
    });
    database.collection('policy').add({
      "name": policy3.policyName,
      "category": (category) % 3 + 1,
      "cost": policy3.cost,
      "validity": policy3.validity,
      "deactivated": true
    });
    policyDao = new PolicyDao(database);

  });

  test('testing get policies function', () async {
    List<Policy> policies = await policyDao.getPolicies(pincode);

    // Only active policies should be present.
    // Only policies of the category of pincode should be present
    expect(policies.length, 1);

    expect(policies[0].policyName, policy1.policyName);
    expect(policies[0].cost, policy1.cost);
    expect(policies[0].validity, policy1.validity);
  });
}
