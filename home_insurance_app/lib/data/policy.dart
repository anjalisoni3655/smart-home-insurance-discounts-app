class Policy {
  String policyName;
  int validity;
  int cost;
  Policy(String policyName, int validity, int cost) {
    this.policyName = policyName;
    this.validity = validity;
    this.cost = cost;
  }

  // copy constructor
  Policy.copy(Policy other) {
    this.policyName = other.policyName;
    this.validity = other.validity;
    this.cost = other.cost;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$policyName, $validity years, $cost';
  }
}
