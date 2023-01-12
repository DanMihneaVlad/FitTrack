import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModel {
  final String uid;
  String mealId;
  String foodName;
  int quantity;
  int portions;
  String ingredientsText;
  String nutriscore;
  double kcal;
  double carbs;
  double sugars;
  double fat;
  double proteins;

  FoodModel({
    required this.uid,
    required this.mealId,
    required this.foodName,
    required this.quantity,
    required this.portions,
    required this.ingredientsText,
    required this.nutriscore,
    required this.kcal,
    required this.carbs,
    required this.sugars,
    required this.fat,
    required this.proteins
  });

  factory FoodModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return FoodModel(
      uid: snapshot.id,
      mealId: data?['mealId'],
      foodName: data?['foodName'],
      quantity: data?['quantity'],
      portions: data?['portions'],
      ingredientsText: data?['ingredientsText'],
      nutriscore: data?['nutriscore'],
      kcal: data?['kcal'],
      carbs: data?['carbs'],
      sugars: data?['sugars'],
      fat: data?['fat'],
      proteins: data?['proteins']
    );
  }
}