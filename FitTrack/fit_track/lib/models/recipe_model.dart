import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecipeModel {
  final String uid;
  String userId;
  String recipeName;

  RecipeModel({ required this.uid,
    required this.userId,
    required this.recipeName });

  factory RecipeModel.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return RecipeModel(uid: snapshot.id, userId: snapshot['userId'], recipeName: snapshot['recipeName']);
  }
}