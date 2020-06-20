import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadUserDetails({String name, String email}) async {
  await Firestore.instance.collection('user').add(
    {
      'name': name,
      'email': email,
    },
  );
}
