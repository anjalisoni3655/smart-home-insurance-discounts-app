// This class  defines the user address structure
class UserAddress {
  String firstLineOfAddress;
  String secondLineOfAddress;
  String city;
  String state;
  int pincode;
  UserAddress(this.firstLineOfAddress, this.secondLineOfAddress, this.city,
      this.state, this.pincode) ;

  @override
  String toString() {
    return '$firstLineOfAddress, $secondLineOfAddress, $city, $state, $pincode';
  }

}
