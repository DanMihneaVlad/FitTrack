import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );

    } catch(e) {

      print(e.toString());
      return null;
    }
  }

  Future register(String email, String password, String confirmedPassword, String firstName, String lastName) async {
    try {
      
      if (password == confirmedPassword) {

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, 
          password: password
        );

        await addUser(email, firstName, lastName);

      }

    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future addUser(String email, String firstName, String lastName) async {
    await FirebaseFirestore.instance.collection('users').add({
      'Email' : email,
      'First Name' : firstName,
      'Last Name' : lastName,
    });
  }

}