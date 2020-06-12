import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:homeinsuranceapp/data/purchase.dart';
import 'package:homeinsuranceapp/data/user_home_details.dart';

Future<List<Policy>> getPolicies(int pincode) async {
  int category = getCategoryFromPincode(pincode);
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

Future<List<Offer>> getOffers() async {
  QuerySnapshot snapshot = await Firestore.instance.collection("offer").getDocuments();
  List<Offer> list = [];
  for(var doc in snapshot.documents) {
    list.add(new Offer(new Map<String, int>.from(doc.data['requirements']), doc.data['discount']));
  }
  return list;
}

Future<List<Purchase>> getInsurances(userId) async {
  // TODO: Hardcoded userId for testing (change to real id)
  userId = 'dp8P9dmXl1DWmqNT9uQq';
  QuerySnapshot snapshot = await Firestore.instance.collection("user").document(userId).collection("insurances_purchased").getDocuments();
  List<Purchase> list = [];
  for(var doc in snapshot.documents) {
    list.add(new Purchase(new Policy(doc.data['policy']['name'], doc.data['policy']['validity'], doc.data['policy']['cost']), new Offer(new Map<String, int>.from(doc.data['offer']['requirements']), doc.data['offer']['discount']), doc.data['structure_id'], doc.data['date_of_purchase'], new UserAddress(doc.data['address']['first_line'], doc.data['address']['second_line'], doc.data['address']['city'], doc.data['address']['state'], doc.data['address']['pincode'])));
  }
  print(list);
  return list;
}

int getCategoryFromPincode(pincode) {
  // Implement business logic of how to assign categories to pincodes
  // right now returning mod 3
  return (pincode % 3) + 1;
}
