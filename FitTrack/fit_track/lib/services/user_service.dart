import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {

  final String uid;
  UserService({ required this.uid });

  final CollectionReference<Map<String, dynamic>> usersCollection = FirebaseFirestore.instance.collection('users');

  Future addUserData(String firstName, String lastName, String email) async {

    try {

      double doublePlaceHolder = 0;
      int intPlaceHolder = 0;
      String stringPlaceHolder = '';

      final docData = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'age': intPlaceHolder,
        'weight': doublePlaceHolder,
        'height': intPlaceHolder,
        'sex': stringPlaceHolder,
        'activityLevel': stringPlaceHolder
      };

      await usersCollection.doc(uid).set(docData);

    } on Exception catch (e) {
      return e;
    }
  }

  Future getUserDetails() async {
    try {

      final DocumentSnapshot<Map<String, dynamic>> data = await usersCollection.doc(uid).get();
      final user = UserModel.fromFirestore(data);

      return user;

    } on Exception catch (e) {
      return e;
    }
  }

  Future updateUserData(String firstName, String lastName, String email) async {

    try {

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

    } on Exception catch (e) {
      return e;
    }
  }

  Future updateUserInformation(String age, String height, String weight, String sex, String activityLevel) async {

    try {

      final docData = {
        'age': int.parse(age),
        'weight': double.parse(weight),
        'height': int.parse(height),
        'sex': sex,
        'activityLevel': activityLevel
      };

      await usersCollection.doc(uid).update(docData);

    } on Exception catch (e) {
      return e;
    }
  }
}