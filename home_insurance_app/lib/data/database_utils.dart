import 'package:cloud_firestore/cloud_firestore.dart';

void addInsurancePurchased(purchase, userId) {
  Firestore.instance
      .collection("user").document(userId).updat
}