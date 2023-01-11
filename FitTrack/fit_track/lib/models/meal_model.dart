import 'package:fit_track/models/food_model.dart';

class MealModel {
  String uid;
  String daySummaryId;
  String mealType;
  Map<String, FoodModel> foods;

  MealModel({
    required this.uid,
    required this.daySummaryId,
    required this.mealType,
    required this.foods
  });
}