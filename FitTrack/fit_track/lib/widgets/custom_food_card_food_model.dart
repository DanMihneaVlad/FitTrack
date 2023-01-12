import 'package:fit_track/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:openfoodfacts/model/Nutrient.dart';
import 'package:openfoodfacts/model/PerSize.dart';
import 'package:openfoodfacts/model/Product.dart';

class CustomFoodCard extends StatelessWidget {
  CustomFoodCard({super.key, required this.food});

  final FoodModel food;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
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
              food.foodName,
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
                    Text(food.kcal.toString()),
                  ],
                ),
                Column(
                  children: [
                    const Text('Carbs'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(food.carbs.toString()),
                  ],
                ),
                Column(
                  children: [
                    const Text('Sugars'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(food.sugars.toString()),
                  ],
                ),
                Column(
                  children: [
                    const Text('Fat'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(food.fat.toString()),
                  ],
                ),
                Column(
                  children: [
                    const Text('Protein'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(food.proteins.toString()),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Quantity: ' + food.quantity.toString(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Ingredient list: ' + food.ingredientsText,
              textAlign: TextAlign.center,
              maxLines: 8,
            ),
            const SizedBox(height: 10),
            Text(
              'Nutriscore: ' + food.nutriscore,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
          ]),
        ),
      ),
    );
  }
}
