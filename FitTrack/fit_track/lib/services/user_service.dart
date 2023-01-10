import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {

  final String uid;
  UserService({ required this.uid });

  final CollectionReference<Map<String, dynamic>> usersCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String firstName, String lastName, String email) async {

    double doublePlaceHolder = 0;
    String stringPlaceHolder = '';

    final docData = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': doublePlaceHolder,
      'weight': doublePlaceHolder,
      'height': doublePlaceHolder,
      'sex': stringPlaceHolder,
      'activityLevel': stringPlaceHolder
    };

    await usersCollection.doc(uid).set(docData);
  }

  Future getUserDetails() async {
    final DocumentSnapshot<Map<String, dynamic>> data = await usersCollection.doc(uid).get();
    final user = UserModel.fromFirestore(data);
    if (user != null) {
      print(user);
    } else {
      print('Nothing');
    }
  }
}