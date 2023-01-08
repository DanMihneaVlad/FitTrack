import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecipeModel {
  final String uid;
  String userId;
  String recipeName;
  List<String> ingredients;
  String description;
  String prepTime;
  String cookTime;
  String portions;
  int kcal;
  int carbs;
  int sugars;
  int fat;
  int protein;

  RecipeModel(
      {required this.uid,
      required this.userId,
      required this.recipeName,
      required this.ingredients,
      required this.description,
      required this.prepTime,
      required this.cookTime,
      required this.portions,
      required this.kcal,
      required this.carbs,
      required this.sugars,
      required this.fat,
      required this.protein});

  factory RecipeModel.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return RecipeModel(
      uid: snapshot.id,
      userId: snapshot['userId'],
      recipeName: snapshot['recipeName'],
      ingredients: [],
      description: "",
      prepTime: "",
      cookTime: "",
      portions: "",
      kcal: 100,
      carbs: 1,
      sugars: 1,
      fat: 1,
      protein: 10
    );
  }
}
