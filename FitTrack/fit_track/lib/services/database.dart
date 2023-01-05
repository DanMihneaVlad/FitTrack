import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String firstName, String lastName, String email) async {
    final docData = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email
    };

    await usersCollection.doc(uid).set(docData);
  }
}