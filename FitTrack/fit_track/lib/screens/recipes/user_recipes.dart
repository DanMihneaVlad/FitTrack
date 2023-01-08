import 'package:fit_track/providers/recipe_provider.dart';
import 'package:fit_track/screens/recipes/recipe_page.dart';
import 'package:fit_track/widgets/custom_recipe_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class UserRecipesWidget extends StatefulWidget {
  UserRecipesWidget({super.key, required this.search});

  String search;

  @override
  State<UserRecipesWidget> createState() => _UserRecipesWidgetState();
}

class _UserRecipesWidgetState extends State<UserRecipesWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var provider = context.watch<RecipeProvider>();

    return FutureBuilder(
      future: provider.getUserRecipesFuture,
      builder: (BuildContext ctx, AsyncSnapshot asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.done) {
          if (asyncSnapshot.hasError) {
            return const Center(child: Text('Could not retreive recipes!'));
          }
          return ListView.builder(
            itemCount: provider.recipes.length,
            itemBuilder: (BuildContext ctx, int index) {
              return GestureDetector(
                onTap: () => { 
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecipePage(recipe: provider.recipes[index])
                    )
                  ),
                },
                child: RecipeCard(recipe: provider.recipes[index]),
              );
            }
          );
        } else {
            return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}