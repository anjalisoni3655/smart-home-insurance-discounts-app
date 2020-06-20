import 'package:homeinsuranceapp/data/purchase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/data/user_home_details.dart';
import 'package:homeinsuranceapp/data/offer.dart';

class PurchaseDao {
  Firestore _database;

  PurchaseDao(this._database);

  Future<List<Purchase>> getInsurances(userId) async {
    QuerySnapshot snapshot = await _database
        .collection("user")
        .document(userId)
        .collection("insurances_purchased")
        .getDocuments();
    List<Purchase> list = [];
    for (var doc in snapshot.documents) {
      list.add(new Purchase(
          new Policy(doc.data['policy']['name'], doc.data['policy']['validity'],
              doc.data['policy']['cost']),
          new Offer(new Map<String, int>.from(doc.data['offer']['requirements']),
              doc.data['offer']['discount']),
          doc.data['structure_id'],
          doc.data['date_of_purchase'],
          new UserAddress(
              doc.data['address']['first_line'],
              doc.data['address']['second_line'],
              doc.data['address']['city'],
              doc.data['address']['state'],
              doc.data['address']['pincode'])));
    }
    return list;
  }

  Future<void> addPurchase(String userId, Purchase purchase) async {
    await _database
        .collection('user')
        .document(userId)
        .collection('insurances_purchased')
        .add({
      'address': {
        'first_line': purchase.address.firstLineOfAddress,
        'second_line': purchase.address.secondLineOfAddress,
        'city': purchase.address.city,
        'state': purchase.address.state,
        'pincode': purchase.address.pincode
      },
      'structure_id': purchase.structureId,
      'date_of_purchase': purchase.dateOfPurchase,
      'policy': {
        'name': purchase.policy.policyName,
        'validity': purchase.policy.validity,
        'cost': purchase.policy.cost
      },
      'offer': {
        'requirements': purchase.offer.requirements,
        'discount': purchase.offer.discount
      },
      'discounted_cost': purchase.discountedCost
    });
  }
}
