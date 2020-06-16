import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/data/deviceType.dart';
import 'package:enum_to_string/enum_to_string.dart';

// This class stores all the discount offers offered by the company

class CompanyDataBase {
  // String of devices on which the company has the option to provide discounts
  static List<String> devices = EnumToString.toList(DeviceType.values);
  static List<Offer> availableOffers = [
    new Offer({'${devices[0]}': 1, '${devices[1]}': 1}, 5),
    new Offer({'${devices[1]}': 1, '${devices[2]}': 1}, 4),
    new Offer({'${devices[3]}': 2}, 3),
    new Offer({'${devices[1]}': 1, '${devices[3]}': 1}, 1),
    new Offer({'${devices[2]}': 2}, 2),
    new Offer({'${devices[1]}': 1}, 1),
    new Offer({'${devices[2]}': 1}, 1)
  ];
}
