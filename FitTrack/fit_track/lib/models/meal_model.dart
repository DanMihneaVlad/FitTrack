import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_track/models/food_model.dart';

class MealModel {
  String uid;
  String daySummaryId;
  String mealType;
  List<FoodModel> foods;

  MealModel({
    required this.uid,
    required this.daySummaryId,
    required this.mealType,
    required this.foods
  });

  factory MealModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    final x = data?['foods'] is Iterable ? List.from(data?['foods']) : null;
    if (x == null) {
      print('null');
    } else {
      print('chestii');
    }
    return MealModel(
      uid: snapshot.id,
      daySummaryId: data?['daySummaryId'],
      mealType: data?['mealType'],
      foods: []
    );
  }
}