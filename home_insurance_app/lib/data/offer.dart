//This class is a structure for each discount offer given by the company  
class Offer{
  Map<String,int> requirements; // This map stores each device type and their corresponding number required for this offer
  int discount;
  Offer(Map<String, int> requirements , int discount){
    this.requirements = requirements;
    this.discount = discount;
  }
}