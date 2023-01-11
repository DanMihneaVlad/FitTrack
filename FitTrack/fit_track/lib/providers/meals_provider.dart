import 'package:fit_track/models/food_model.dart';
import 'package:fit_track/models/meal_model.dart';
import 'package:flutter/cupertino.dart';

import '../models/day_summary_model.dart';
import '../services/day_summary_service.dart';
import '../services/meals_service.dart';

class MealsProvider extends ChangeNotifier {
  late DaySummaryService _daySummaryService;
  late MealsService _mealsService;
  late DaySummaryModel todayDaySummary;
  List<MealModel> meals = [];
  late Future getTodayDaySummary;
  final String uid;

  MealsProvider({required this.uid}) {
    _daySummaryService = DaySummaryService(uid: uid);
    _mealsService = MealsService();
    getTodayDaySummary = _getTodayDaySummaryFuture();
  }

  Future _getTodayDaySummaryFuture() async {
    final _daySummary = await _daySummaryService.getTodayDaySummary();

    if (_daySummary is DaySummaryModel) {
      todayDaySummary = _daySummary;
    } else {
      todayDaySummary = _createDefaultDaySummary();
    }
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

      notifyListeners();
    } on Exception catch (e) {
      return e;
    }
    
  }

  DaySummaryModel _createDefaultDaySummary() {
    return DaySummaryModel(uid: '', userId: '', date: '', caloriesConsumed: 0.0, carbs: 0.0, sugars: 0.0, fats: 0.0, proteins: 0.0);
  }

  MealModel _createMeal(String mealId, String daySummaryId, String mealType) {
    return MealModel(uid: mealId, daySummaryId: daySummaryId, mealType: mealType, foods: <String, FoodModel>{});
  }
}