import 'package:fit_track/models/food_model.dart';
import 'package:fit_track/models/meal_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Nutrient.dart';
import 'package:openfoodfacts/model/PerSize.dart';
import 'package:openfoodfacts/model/Product.dart';

import '../models/day_summary_model.dart';
import '../services/day_summary_service.dart';
import '../services/food_service.dart';
import '../services/meals_service.dart';

class MealsProvider extends ChangeNotifier {
  late DaySummaryService _daySummaryService;
  late MealsService _mealsService;
  late FoodService _foodService;
  late DaySummaryModel todayDaySummary;
  List<MealModel> meals = [];
  Map<String, List<FoodModel>> mealFoods = {};
  late Future getTodayDaySummary;
  final String uid;

  MealsProvider({required this.uid}) {
    _daySummaryService = DaySummaryService(uid: uid);
    _mealsService = MealsService();
    _foodService = FoodService();
    getTodayDaySummary = _getTodayDaySummaryFuture();
  }

  Future _getTodayDaySummaryFuture() async {
    final _daySummary = await _daySummaryService.getTodayDaySummary();

    if (_daySummary is DaySummaryModel) {
      todayDaySummary = _daySummary;
      try {
        await _getTodayMealsFuture(todayDaySummary.uid);
      } on Exception catch (e) {
        return e;
      }
    } else {
      todayDaySummary = _createDefaultDaySummary();
    }
  }

  Future _getTodayMealsFuture(String daySummaryId) async {
    meals = await _mealsService.getTodayMeals(daySummaryId);
    if(meals.isNotEmpty) {
      for (MealModel meal in meals) {
        List<FoodModel> foods = await _getFoodsFuture(meal.uid);

        mealFoods[meal.uid] = foods;
      }
    }
  }

  Future _getFoodsFuture(String mealId) async {
    List<FoodModel> foods = await _foodService.getFoods(mealId);
    return foods;
  }

  Future addMeal(String mealType) async {

    try {

      if (todayDaySummary.uid == '') {
        List<String> daySummaryInfo = await _daySummaryService.addDaySummary();
        todayDaySummary.uid = daySummaryInfo[0];
        todayDaySummary.userId = uid;
        todayDaySummary.date = daySummaryInfo[1];
      }

      String mealId = await _mealsService.addMeal(todayDaySummary.uid, mealType);
      MealModel meal = _createMeal(mealId, todayDaySummary.uid, mealType);
      meals.add(meal);
      mealFoods[mealId] = <FoodModel>[];

      notifyListeners();
    } on Exception catch (e) {
      return e;
    }
    
  }

  Future addFoodProduct(String mealId, int quantity, Product foodProduct) async {
    
    try {

      FoodModel food = await _foodService.addFood(mealId, quantity, foodProduct);

      mealFoods[mealId]!.add(food);

      await _daySummaryService.updateDaySummary(todayDaySummary, food.kcal, food.carbs, food.sugars, food.fat, food.proteins);

      todayDaySummary.caloriesConsumed += food.kcal;
      todayDaySummary.carbs += food.carbs;
      todayDaySummary.sugars += food.sugars;
      todayDaySummary.fats += food.fat;
      todayDaySummary.proteins += food.proteins;

      notifyListeners();
    } on Exception catch (e) {
      return e;
    }
  }

  DaySummaryModel _createDefaultDaySummary() {
    return DaySummaryModel(uid: '', userId: '', date: '', caloriesConsumed: 0.0, carbs: 0.0, sugars: 0.0, fats: 0.0, proteins: 0.0);
  }

  MealModel _createMeal(String mealId, String daySummaryId, String mealType) {
    return MealModel(uid: mealId, daySummaryId: daySummaryId, mealType: mealType);
  }
}