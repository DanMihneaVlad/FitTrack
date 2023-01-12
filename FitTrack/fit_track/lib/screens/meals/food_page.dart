import 'package:fit_track/models/food_model.dart';
import 'package:fit_track/providers/meals_provider.dart';
import 'package:fit_track/screens/meals/scan_product.dart';
import 'package:fit_track/screens/meals/search_product.dart';
import 'package:fit_track/widgets/custom_appbar.dart';
import 'package:fit_track/widgets/custom_food_card.dart';
import 'package:fit_track/widgets/custom_meal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:openfoodfacts/model/Nutrient.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/PerSize.dart';
import 'package:openfoodfacts/model/Product.dart';
import 'package:provider/provider.dart';

import '../../models/meal_model.dart';
import '../../widgets/custom_food_card_food_model.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key, required this.meal, required this.foods});

  final MealModel meal;
  final List<FoodModel> foods;

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.meal.mealType, backButton: true),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                    itemCount: widget.foods.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Container(
                        child: CustomFoodCard(food: widget.foods[index]),
                      );
                    }),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider.value(
                            value: context.read<MealsProvider>(),
                            child: SearchProduct(mealId: widget.meal.uid),
                          ),
                          settings: const RouteSettings(name: 'FoodPage')
                        )
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Search\nproduct',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider.value(
                            value: context.read<MealsProvider>(),
                            child: ScanProduct(mealId: widget.meal.uid),
                          ),
                          settings: const RouteSettings(name: 'FoodPage')
                        )
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Scan\nproduct',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
      ),
    );
  }

  Product _createProduct(FoodModel food) {
    return Product(productName: food.foodName, quantity: food.quantity.toString(), ingredientsText: food.ingredientsText, noNutritionData: false);
  }
}
