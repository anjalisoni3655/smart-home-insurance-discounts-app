import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> uploadUserDetailsGetUID({String name, String email}) async {
  final _firestore = Firestore.instance;
  final _id = _firestore.collection('user').document().documentID;
  await _firestore.collection('user').document(_id).setData(
    {
      'name': name,
      'email': email,
    },
  );
  return _id;
}
