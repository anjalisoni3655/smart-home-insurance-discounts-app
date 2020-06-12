import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homeinsuranceapp/data/policy.dart';
import 'package:flutter/material.dart';

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

int getCategoryFromPincode(pincode) {
  // Implement business logic of how to assign categories to pincodes
  // right now returning mod 3
  return (pincode % 3) + 1;
}

final localStorage = FlutterSecureStorage();

Future<void> uploadUserDetails(
    {String name, String email, String photourl}) async {
  await localStorage.write(key: 'name', value: name);
  await localStorage.write(key: 'email', value: email);
  await localStorage.write(key: 'photourl', value: photourl);
  await Firestore.instance.collection('user').document(email).setData({
    'name': name,
    'email': email,
  }, merge: true);
}
