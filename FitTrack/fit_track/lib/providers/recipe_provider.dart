import 'package:fit_track/models/recipe_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../services/recipe_service.dart';

class RecipeProvider extends ChangeNotifier {
  late RecipeService _recipeService;
  List<RecipeModel> recipes = [];
  List<RecipeModel> otherRecipes = [];
  late Future getUserRecipesFuture;
  late Future getOtherRecipesFuture;
  final String uid;

  RecipeProvider({required this.uid}) {
    _recipeService = RecipeService(uid: uid);
    getUserRecipesFuture = _getUserRecipesFuture();
    getOtherRecipesFuture = _getOtherRecipesFuture();
  }

  Future _getUserRecipesFuture() async {
    recipes = await _recipeService.getUserRecipes();
  }

  Future _getOtherRecipesFuture() async {
    otherRecipes = await _recipeService.getOtherRecipes();
  }

  Future addRecipe(
      String recipeName,
      XFile? image,
      List<String> ingredients,
      String instructions,
      String prepTime,
      String cookTime,
      String portions,
      String kcal,
      String carbs,
      String sugars,
      String fat,
      String protein) async {
    try {
      List<String> x = await _recipeService.addRecipe(
          recipeName,
          image,
          ingredients,
          instructions,
          prepTime,
          cookTime,
          portions,
          kcal,
          carbs,
          sugars,
          fat,
          protein);

      recipes.add(RecipeModel(
          uid: x[0],
          userId: uid,
          recipeName: recipeName,
          imageUrl: x[1],
          ingredients: ingredients,
          instructions: instructions,
          prepTime: prepTime,
          cookTime: cookTime,
          portions: portions,
          kcal: double.parse(kcal),
          carbs: double.parse(carbs),
          sugars: double.parse(sugars),
          fat: double.parse(fat),
          protein: double.parse(protein)));

      notifyListeners();
    } on Exception catch (e) {
      return e;
    }
  }
}
