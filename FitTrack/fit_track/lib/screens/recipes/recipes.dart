import 'package:fit_track/providers/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    var recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      body: Text('Recipe page'),
    );
  }
}