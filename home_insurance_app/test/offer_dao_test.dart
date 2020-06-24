import 'package:flutter_test/flutter_test.dart';
import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/data/offer_dao.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';

void main() {
  MockFirestoreInstance database;
  OfferDao offerDao;

  Offer offer1 = new Offer({'Camera': 1, 'Thermostat': 2}, 4);
  Offer offer2 = new Offer({'Thermostat': 1}, 2);

  setUp(() async {
    database = new MockFirestoreInstance();
    await database.collection('offer').add(
        {'requirements': offer1.requirements, 'discount': offer1.discount});
    await database.collection('offer').add(
        {'requirements': offer2.requirements, 'discount': offer2.discount});
    offerDao = new OfferDao(database);
  });

  test('testing get policies function', () async {
    List<Offer> offers = await offerDao.getOffers();

    expect(offers.length, 2);

    expect(offers[0].requirements, offer1.requirements);
    expect(offers[0].discount, offer1.discount);
    expect(offers[1].requirements, offer2.requirements);
    expect(offers[1].discount, offer2.discount);
  });
}
