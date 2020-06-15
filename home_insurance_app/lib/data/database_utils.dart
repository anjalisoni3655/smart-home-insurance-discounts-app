void addInsurancePurchased(purchase) {
  print(purchase);
  // TODO: push purchase to database
}

double getFinalDiscount({int cost, int discount}) {
  return cost * 0.01 * discount;
}

double getFinalAmount({int cost, int discount}) {
  return cost * (1 - 0.01 * discount);
}
