//This class is a structure for each discount offer given by the company
class Offer {
  Map<String, int>
      requirements; // This map stores each device type and their corresponding number required for this offer
  int discount;
  Offer(Map<String, int> requirements, int discount) {
    this.requirements = requirements;
    this.discount = discount;
  }

  @override
  String toString() {
    String offer = '';
    for (String device in requirements.keys) {
      offer += '${requirements[device]} $device\n';
    }
    offer = offer.substring(0, offer.length - 1);
    return offer;
  }
}
