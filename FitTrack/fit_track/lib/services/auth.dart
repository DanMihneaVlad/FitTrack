import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/models/user_model.dart';
import 'package:fit_track/services/user_service.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    try {
      
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      final user = _auth.currentUser;
      if (user != null) {
        print(user);
      }
      
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future register(String email, String password, String confirmedPassword, String firstName, String lastName) async {
    try {
      
      if (password == confirmedPassword) {

        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, 
          password: password
        );

        User? registeredUser = userCredential.user;

        if (registeredUser != null) {
          await UserService(uid: registeredUser.uid).addUserData(firstName, lastName, email);
        }

      }

    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future signOut() async {
    try {

      return await _auth.signOut();

    } catch (e) {
      return null;
    }
  }

}