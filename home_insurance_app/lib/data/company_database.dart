import 'package:homeinsuranceapp/data/offer.dart';
import 'package:homeinsuranceapp/data/device_type.dart';

// This class stores all the discount offers offered by the company

class CompanyDataBase {
  // String of devices on which the company has the option to provide discounts
  static List<Offer> availableOffers = [
    new Offer({
      '${deviceName[DeviceType.SMOKE_CO_DETECTOR.index]}': 1,
      '${deviceName[DeviceType.THERMOSTAT.index]}': 1
    }, 5),
    new Offer({
      '${deviceName[DeviceType.THERMOSTAT.index]}': 1,
      '${deviceName[DeviceType.CAMERA.index]}': 1
    }, 4),
    new Offer({'${deviceName[DeviceType.DOORBELL.index]}': 2}, 3),
    new Offer({
      '${deviceName[DeviceType.THERMOSTAT.index]}': 1,
      '${deviceName[DeviceType.DOORBELL.index]}': 1
    }, 1),
    new Offer({'${deviceName[DeviceType.CAMERA.index]}': 2}, 2),
    new Offer({'${deviceName[DeviceType.THERMOSTAT.index]}': 1}, 1),
    new Offer({'${deviceName[DeviceType.CAMERA.index]}': 1}, 1)
  ];
}
