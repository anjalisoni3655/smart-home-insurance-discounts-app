// This class defines the policy structure
class Policy {
  String policyName;
  int validity;
  int cost;
  Policy(String policyName, int validity, int cost) {
    this.policyName = policyName;
    this.validity = validity;
    this.cost = cost;
  }
}
