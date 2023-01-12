import 'package:fit_track/models/food_model.dart';
import 'package:fit_track/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.meal, required this.foods});

  final MealModel meal;
  final List<FoodModel> foods;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Container(
        height: 80,
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
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(
              meal.mealType,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(foods.length.toString() + ' food products added', textAlign: TextAlign.center,)
          ]),
        ),
      ),
    );
  }
}
