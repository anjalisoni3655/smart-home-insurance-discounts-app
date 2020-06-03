class Policy{
  int pincode ;
  List<String>policies;
  
  Policy(this.pincode);
  
  List<String> get_policies () {
    if(pincode > 110000 && pincode < 110500){
      policies = ["Tenant's Home Insurance",'Contents Insurance','Burglary and Theft','Personal Accident',"Public Liability Coverage","Loss In Natural Disaster","Landlord's Insurance"];
    }
    else if(pincode >= 110500 && pincode < 111000){
      policies = ["Public Liability Coverage",'Contents Insurance','Burglary and Theft','Home Structure Insurance',"Loss In Natural Disaster","Landlord's Insurance"];
    }
    else if(pincode >= 111000 && pincode < 112000){
     policies = ["Standard Fire and Perils Policy","Tenant's Home Insurance",'Public Liability Coverage','Home Structure Insurance',"Loss In Natural Disaster","Landlord's Insurance"];  
    }
    else {
      policies = ['Burglary and Theft',"Standard Fire and Perils Policy","Tenant's Home Insurance",'Public Liability Coverage',"Landlord's Insurance","Loss In Natural Disaster"]; 
    }
    return policies ;
  }
}