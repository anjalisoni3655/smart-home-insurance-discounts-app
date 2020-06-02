class User {
  String displayName;
  String email;
  String photoUrl;

  User({this.displayName, this.email, this.photoUrl});

  @override
  bool operator ==(other) {
    return email == other.email;
  }

  @override
  int get hashCode => email.hashCode;



}