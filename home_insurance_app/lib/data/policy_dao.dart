import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeinsuranceapp/data/policy.dart';

class PolicyDao {
  static Future<List<Policy>> getPolicies(int pincode) async {
    int category = _getCategoryFromPincode(pincode);
    QuerySnapshot snapshot = await Firestore.instance
        .collection('policy')
        .where('category', isEqualTo: category)
        .where('deactivated', isEqualTo: false)
        .getDocuments();
    List<Policy> list = [];
    for (var doc in snapshot.documents) {
      list.add(
          new Policy(doc.data['name'], doc.data['validity'], doc.data['cost']));
    }
    return list;
  }

  static int _getCategoryFromPincode(pincode) {
    // Implement business logic of how to assign categories to pincodes
    // right now returning mod 3
    return (pincode % 3) + 1;
  }
}
