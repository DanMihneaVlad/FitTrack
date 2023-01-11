import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_track/models/food_model.dart';

class MealsService {

  MealsService();

  final CollectionReference<Map<String, dynamic>> mealsCollection = FirebaseFirestore.instance.collection('meals');

  Future getMeals(String daySummaryId) async {
    try {

      final QuerySnapshot<Map<String, dynamic>> response = await mealsCollection.where('userId', isEqualTo: daySummaryId).get();
      
      if (response.docs.isNotEmpty) {
        
        //final daySummary = DaySummaryModel.fromFirestore(response.docs[0]);
        print('Got response');
        //return daySummary;
      } else {
        return null;
      }

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
}