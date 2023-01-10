import 'package:fit_track/models/recipe_model.dart';
import 'package:fit_track/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.recipe});

  final RecipeModel recipe;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<String> nutritionElements = [
    'Kcal',
    'Carbs',
    'Sugars',
    'Fat',
    'Protein'
  ];
  List<String> nutritionValues = [];

  @override
  Widget build(BuildContext context) {
    addValues();

    return Scaffold(
      appBar: CustomAppBar(title: 'Recipe details', backButton: true),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),

              Text(
                widget.recipe.recipeName,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Recipe image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  alignment: Alignment.center,
                  child: Image.network(widget.recipe.imageUrl,
                      height: 220, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 20),

              // Preparation details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.kitchen, color: Colors.blue[500]),
                      const Text('Prep time'),
                      Text(widget.recipe.prepTime + ' min'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.timer, color: Colors.blue[500]),
                      const Text('Cook time'),
                      Text(widget.recipe.cookTime + ' min'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.restaurant, color: Colors.blue[500]),
                      const Text('Portions'),
                      Text(widget.recipe.portions),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),

              // Ingredient list
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Ingredient list',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.recipe.ingredients!.map((str) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          '\u2022',
                          style: TextStyle(fontSize: 12, height: 1.5),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(str, style: TextStyle(fontSize: 14)),
                      )
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),

              // Nutrition details
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Nutrition per serving',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    buildRow(nutritionElements, isHeader: true),
                    buildRow(nutritionValues)
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Instructions
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Instructions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                  ),
                  Expanded(
                    child: Text(widget.recipe.instructions,
                        style: TextStyle(fontSize: 14)),
                  )
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
          children: cells.map((cell) {
        final style = TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: 14);

        return Padding(
            padding: const EdgeInsets.all(8),
            child: Center(child: Text(cell, style: style)));
      }).toList());

  void addValues() {
    nutritionValues.add(widget.recipe.kcal.toString());
    nutritionValues.add('${widget.recipe.carbs}g');
    nutritionValues.add('${widget.recipe.sugars}g');
    nutritionValues.add('${widget.recipe.fat}g');
    nutritionValues.add('${widget.recipe.protein}g');
  }
}
