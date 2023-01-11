import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_track/models/food_model.dart';
import 'package:fit_track/models/meal_model.dart';

class MealsService {

  MealsService();

  final CollectionReference<Map<String, dynamic>> mealsCollection = FirebaseFirestore.instance.collection('meals');

  Future getTodayMeals(String daySummaryId) async {
    try {

      final QuerySnapshot<Map<String, dynamic>> response = await mealsCollection.where('daySummaryId', isEqualTo: daySummaryId).get();
      
      final data = response.docs.map((DocumentSnapshot<Map<String,dynamic>> doc) => MealModel.fromFirestore(doc)).toList();
      return data;

    } on Exception catch (e) {
      return e;
    }
  }

  Future addMeal(String daySummaryId, String mealType) async {

    try {

      double doublePlaceHolder = 0;

      final docData = {
        'daySummaryId': daySummaryId,
        'mealType': mealType,
        'foods': <String, FoodModel>{}
      };

      DocumentReference addedMeal = await mealsCollection.add(docData);
      DocumentSnapshot doc = await addedMeal.get();
      
      return doc.id;

    } on Exception catch (e) {
      return e;
    }
  }

  Future updateMeal(String mealId, List<FoodModel> foods) async {

  }
}