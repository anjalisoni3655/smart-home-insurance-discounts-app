import 'package:homeinsuranceapp/data/offer.dart';

// This class contains all teh discounts offered by the insurance company
class CompanyDataBase {
  static List<Offer> availableOffers = [
    new Offer(
        {'Nest Hello Doorbell': 1, 'Nest Protect - Smoke + CO alarm': 1}, 50),
    new Offer({'Nest Cam IQ Outdoor': 1, 'Nest Thermostat': 1}, 45),
    new Offer({'Nest Protect- Smoke + CO alarm': 2}, 38),
    new Offer({'Nest X Yale Lock': 1, 'Nest Hello Doorbell': 1}, 18),
    new Offer({'Nest Protect - Smoke + CO alarm': 2}, 10),
    new Offer({'Nest X Yale Lock': 1}, 8),
    new Offer({'Nest X Yale Lock': 1}, 8)
  ];

  int getTotalDiscount(List<Offer> userChoice) {
    int totalDiscount = 0;
    for (int i = 0; i < userChoice.length; i++) {
      totalDiscount += (userChoice[i].discount);
    }
    return (totalDiscount);
  }

  double getFinalCost(int policyCost, int totalDiscount) {
    return (((100 - totalDiscount) / 100) * policyCost);
  }
}
