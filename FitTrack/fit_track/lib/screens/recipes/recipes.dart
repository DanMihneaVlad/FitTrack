import 'package:fit_track/providers/recipe_provider.dart';
import 'package:fit_track/screens/recipes/add_recipe.dart';
import 'package:fit_track/screens/recipes/user_recipes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

const List<Widget> recipes = <Widget>[
  Text('My recipes'),
  Text('Other recipes')
];

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {

  final List<bool> _selectedRecipes = <bool>[true, false];

  final _searchContoller = TextEditingController();

  @override
  void dispose() {
    _searchContoller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              
              ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _selectedRecipes.length; i++) {
                      _selectedRecipes[i] = i == index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                selectedBorderColor: Colors.blue[700],
                selectedColor: Colors.white,
                fillColor: Colors.blue[200],
                color: Colors.blue[400],
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 165.0,
                ),
                isSelected: _selectedRecipes,
                children: recipes
              ),

              SizedBox(height: 10),
          
              // Search textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  controller: _searchContoller,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Search',
                    fillColor: Colors.grey[250],
                    filled: true
                  ),
                ),
              ),
              SizedBox(height: 20),

              Expanded(
                child: UserRecipesWidget(search: _searchContoller.text.trim()),
              ),

            ],
          )
        ),
      ),
      floatingActionButton: _getFAB()
    );
  }

  Widget _getFAB() {
    if (_selectedRecipes[1]) {
      return Container();
    } else {
      return FloatingActionButton(
        child: Icon(Icons.add, size: 35),
        onPressed: () => { 
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddRecipe()
            )
          ),
        },
      );
    }
  }
}