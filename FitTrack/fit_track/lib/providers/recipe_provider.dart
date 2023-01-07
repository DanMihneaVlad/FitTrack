import 'package:fit_track/models/recipe_model.dart';
import 'package:flutter/cupertino.dart';
import '../services/recipe_service.dart';

class RecipeProvider extends ChangeNotifier {

  late RecipeService _recipeService;
  List<RecipeModel> recipes = [];
  late Future getUserRecipesFuture;
  final String uid;

  RecipeProvider({ required this.uid }) {
    _recipeService = RecipeService(uid: uid);
    getUserRecipesFuture = _getUserRecipesFuture();
    
  }

  Future _getUserRecipesFuture() async {
    recipes = await _recipeService.getUserRecipes();
  }
}