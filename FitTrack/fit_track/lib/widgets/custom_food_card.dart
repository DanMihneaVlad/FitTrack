import 'package:fit_track/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:openfoodfacts/model/Nutrient.dart';
import 'package:openfoodfacts/model/PerSize.dart';
import 'package:openfoodfacts/model/Product.dart';

class FoodCard extends StatelessWidget {
  FoodCard({super.key, required this.food});

  final Product food;

  @override
  Widget build(BuildContext context) {
    String ingredientsText = food.ingredientsText ?? '';
    String quantity = food.quantity ?? '';
    String nutriscore = food.nutriscore ?? '';
    String kcal = '-';
    String carbs = '-';
    String sugars = '-';
    String fat = '-';
    String proteins = '-';
    if (food.noNutritionData == false) {
      kcal = food.nutriments!.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams).toString();
      carbs = food.nutriments!.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams).toString();
      sugars = food.nutriments!.getValue(Nutrient.sugars, PerSize.oneHundredGrams).toString();
      fat = food.nutriments!.getValue(Nutrient.fat, PerSize.oneHundredGrams).toString();
      proteins = food.nutriments!.getValue(Nutrient.proteins, PerSize.oneHundredGrams).toString();
    }

    return Container(
      height: 350,
      width: 500,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 194, 194, 194),
              spreadRadius: 1.5,
              blurRadius: 5,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            food.productName ?? 'Product',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Nutriment data per 100g',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Nutrition details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text('Kcal'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(kcal),
                ],
              ),
              Column(
                children: [
                  const Text('Carbs'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(carbs),
                ],
              ),
              Column(
                children: [
                  const Text('Sugars'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(sugars),
                ],
              ),
              Column(
                children: [
                  const Text('Fat'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(fat),
                ],
              ),
              Column(
                children: [
                  const Text('Protein'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(proteins),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Quantity: ' + quantity,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Ingredient list: ' + ingredientsText,
            textAlign: TextAlign.center,
            maxLines: 8,
          ),
          const SizedBox(height: 10),
          Text(
            'Nutriscore: ' + nutriscore,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
        ]),
      ),
    );
  }
}
