import 'package:homeinsuranceapp/data/policy.dart';

class CompanyPolicies {
  int pincode;
  final List<Policy> policies1 = [
    Policy("Tenant's Home Insurance", 6, 2000),
    Policy('Contents Insurance', 6, 3000),
    Policy('Burglary and Theft', 7, 5000),
    Policy('Personal Accident', 7, 1000),
    Policy("Public Liability Coverage", 2, 1000),
    Policy("Loss In Natural Disaster", 3, 4000),
  ];
  final List<Policy> policies2 = [
    Policy("Public Liability Coverage", 6, 5000),
    Policy('Contents Insurance', 6, 3000),
    Policy('Burglary and Theft', 7, 2000),
    Policy('Home Structure Insurance', 7, 4000),
    Policy("Loss In Natural Disaster", 3, 7000),
    Policy("Landlord's Insurance", 5, 5000)
  ];
  final List<Policy> policies3 = [
    Policy("Standard Fire and Perils Policy", 6, 7000),
    Policy("Tenant's Home Insurance", 6, 2000),
    Policy('Burglary and Theft', 7, 5000),
    Policy('Public Liability Coverage', 7, 1000),
    Policy('Home Structure Insurance', 2, 5000),
    Policy("Loss In Natural Disaster", 3, 4000),
    Policy("Landlord's Insurance", 5, 5000)
  ];
  final List<Policy> policies4 = [
    Policy("Tenant's Home Insurance", 6, 2000),
    Policy('Contents Insurance', 6, 6000),
    Policy('Personal Accident', 7, 1000),
    Policy("Public Liability Coverage", 2, 1000),
    Policy("Loss In Natural Disaster", 3, 4000),
    Policy("Standard Fire and Perils Policy", 7, 5000),
    Policy("Loss In Natural Disaster", 5, 5000)
  ];

  CompanyPolicies(this.pincode);

  List<Policy> get_policies() {
    if (pincode > 110000 && pincode < 110500) {
      return policies1;
    } else if (pincode >= 110500 && pincode < 111000) {
      return policies2;
    } else if (pincode >= 111000 && pincode < 112000) {
      return policies3;
    } else {
      return policies4;
    }
  }
}
