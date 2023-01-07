import 'package:fit_track/models/recipe_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({ super.key, required this.recipe });

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 194, 194, 194),
              spreadRadius: 1.5,
              blurRadius: 5,
            ),
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            children: [
              Container(
                child: Image.asset("assets/img/pizza.jpg"),
              )
            ]
          ),
        ),
      ),
    );
  }
}