import 'package:homeinsuranceapp/data/offer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfferDao {
  static Future<List<Offer>> getOffers() async {
    QuerySnapshot snapshot =
    await Firestore.instance.collection("offer").getDocuments();
    List<Offer> list = [];
    for (var doc in snapshot.documents) {
      list.add(new Offer(new Map<String, int>.from(doc.data['requirements']),
          doc.data['discount']));
    }
    return list;
  }
}