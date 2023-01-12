import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_track/models/food_model.dart';
import 'package:openfoodfacts/model/Nutrient.dart';
import 'package:openfoodfacts/model/PerSize.dart';
import 'package:openfoodfacts/model/Product.dart';

class FoodService {
  
  final CollectionReference<Map<String, dynamic>> foodsCollection = FirebaseFirestore.instance.collection('foods');

  Future getFoods(String mealId) async {
    try {

      final QuerySnapshot<Map<String, dynamic>> response = await foodsCollection.where('mealId', isEqualTo: mealId).get();
      
      final data = response.docs.map((DocumentSnapshot<Map<String,dynamic>> doc) => FoodModel.fromFirestore(doc)).toList();
      return data;

    } on Exception catch (e) {
      return e;
    }
  }

  Future addFood(String mealId, int quantity, Product foodProduct) async {

    try {

      String foodName = foodProduct.productName ?? '';
      String ingredientsText = foodProduct.ingredientsText ?? '';
      String nutriscore = foodProduct.nutriscore ?? '';
      double kcal = foodProduct.nutriments!.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams) ?? 0;
      double carbs = foodProduct.nutriments!.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ?? 0;
      double sugars = foodProduct.nutriments!.getValue(Nutrient.sugars, PerSize.oneHundredGrams) ?? 0;
      double fat = foodProduct.nutriments!.getValue(Nutrient.fat, PerSize.oneHundredGrams) ?? 0;
      double proteins = foodProduct.nutriments!.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ?? 0;

      kcal = kcal * quantity / 100.0;
      carbs = carbs * quantity / 100.0;
      sugars = sugars * quantity / 100.0;
      fat = fat * quantity / 100.0;
      proteins = proteins * quantity / 100.0;

      final docData = {
        'mealId': mealId,
        'foodName': foodName,
        'ingredientsText': ingredientsText,
        'nutriscore': nutriscore,
        'quantity': quantity,
        'portions': 0,
        'kcal': kcal,
        'carbs': carbs,
        'sugars': sugars,
        'fat': fat,
        'proteins': proteins
      };

      DocumentReference addedFood = await foodsCollection.add(docData);
      DocumentSnapshot<Map<String, dynamic>> doc = await addedFood.get() as DocumentSnapshot<Map<String, dynamic>>;
      
      return FoodModel.fromFirestore(doc);

    } on Exception catch (e) {
      return e;
    }
  }
}