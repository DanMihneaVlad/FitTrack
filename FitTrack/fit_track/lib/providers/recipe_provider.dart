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
    addDummyRecipe();
  }

  Future addDummyRecipe() async {
    try{
      recipes.add(RecipeModel(uid: "test", userId: "test", recipeName: "PorkPorkPorkPorkPork PorkPorkPork", ingredients: ["pork"], instructions: "We start by cooking bite-sized chicken breast and chopped onion in a large high-sided ovenproof skillet. It's important to use a large high-sided ovenproof skillet as it has the capacity to cook the ingredients without overcrowding the pan. Flour is added, then milk is added and brought to a boil for 1 minute. Make sure to stir frequently during this step. The flour helps thicken the casserole and the reduced-fat milk makes it creamy without the added fat.We start by cooking bite-sized chicken breast and chopped onion in a large high-sided ovenproof skillet. It's important to use a large high-sided ovenproof skillet as it has the capacity to cook the ingredients without overcrowding the pan. Flour is added, then milk is added and brought to a boil for 1 minute. Make sure to stir frequently during this step. The flour helps thicken the casserole and the reduced-fat milk makes it creamy without the added fat.", prepTime: "20 min", cookTime: "1 hour", portions: "1", kcal: 100, carbs: 1, fat: 1, sugars: 1, protein: 10));
      recipes.add(RecipeModel(uid: "test1", userId: "test1", recipeName: "Pizza", ingredients: ["salamisalamisalamisalamisalamisalamisalamisalami with pizza salamisalamisalamisalamisalami with pizzabigaf salamisalamisalamisalamisalamisalamisalamisalamisalamisalamisalamisalamisalamisalamisalamisalamisalami", "tomatoes"], instructions: "Cook pizza", prepTime: "20 min", cookTime: "1 hour", portions: "1", kcal: 100, carbs: 1, fat: 1, sugars: 1, protein: 10));
      recipes.add(RecipeModel(uid: "test2", userId: "test2", recipeName: "Burger", ingredients: ["bun", "patty"], instructions: "Make burger", prepTime: "20 min", cookTime: "1 hour", portions: "1", kcal: 100, carbs: 1, fat: 1, sugars: 1, protein: 10));
      notifyListeners();
    } on Exception catch (e) {
      return e;
    }
  }
}