import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecipeModel {
  final String uid;
  String userId;
  String recipeName;
  String imageUrl;
  List<String>? ingredients;
  String instructions;
  String prepTime;
  String cookTime;
  String portions;
  double kcal;
  double carbs;
  double sugars;
  double fat;
  double protein;

  RecipeModel(
      {required this.uid,
      required this.userId,
      required this.recipeName,
      required this.imageUrl,
      required this.ingredients,
      required this.instructions,
      required this.prepTime,
      required this.cookTime,
      required this.portions,
      required this.kcal,
      required this.carbs,
      required this.sugars,
      required this.fat,
      required this.protein});

  factory RecipeModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return RecipeModel(
      uid: snapshot.id,
      userId: data?['userId'],
      recipeName: data?['recipeName'],
      imageUrl: data?['imageUrl'],
      ingredients: data?['ingredients'] is Iterable ? List.from(data?['ingredients']) : null,
      instructions: data?['instructions'],
      prepTime: data?['prepTime'],
      cookTime: data?['cookTime'],
      portions: data?['portions'],
      kcal: data?['kcal'],
      carbs: data?['carbs'],
      sugars: data?['sugars'],
      fat: data?['fat'],
      protein: data?['protein']
    );
  }
}
