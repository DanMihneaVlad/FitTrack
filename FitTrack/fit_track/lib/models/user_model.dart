import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String uid;
  String firstName;
  String lastName;
  String email;
  int age;
  double weight;
  int height;
  String sex;
  String activityLevel;

  UserModel({ required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
    required this.weight,
    required this.height,
    required this.sex,
    required this.activityLevel });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot
  ) {
    final data = snapshot.data();
    return UserModel(
      uid: snapshot.id, 
      firstName: data?['firstName'], 
      lastName: data?['lastName'], 
      email: data?['email'], 
      age: data?['age'], 
      weight: data?['weight'], 
      height: data?['height'], 
      sex: data?['sex'], 
      activityLevel: data?['activityLevel']
    );
  }


  Map<String, dynamic> toFirestore() {
    return {
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (email != null) "email": email,
      if (age != null) "age": age,
      if (weight != null) "weight": weight,
      if (height != null) "height": height,
      if (sex != null) "sex": sex,
      if (activityLevel != null) "activityLevel": activityLevel,
    };
  }
}