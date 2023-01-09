import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecipeModel {
  final String uid;
  String userId;
  String recipeName;
  String imageUrl;
  List<String> ingredients;
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

  factory RecipeModel.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return RecipeModel(
      uid: snapshot.id,
      userId: snapshot['userId'],
      recipeName: snapshot['recipeName'],
      imageUrl: snapshot['imageUrl'],
      ingredients: ['ingredients'],
      instructions: snapshot['instructions'],
      prepTime: snapshot['prepTime'],
      cookTime: snapshot['cookTime'],
      portions: snapshot['portions'],
      kcal: snapshot['kcal'],
      carbs: snapshot['carbs'],
      sugars: snapshot['sugars'],
      fat: snapshot['fat'],
      protein: snapshot['protein']
    );
  }
}
