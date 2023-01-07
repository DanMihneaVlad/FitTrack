import 'package:fit_track/models/recipe_model.dart';
import 'package:fit_track/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({ super.key, required this.recipe });

  final RecipeModel recipe;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Recipe details', backButton: true),
    );
  }
}