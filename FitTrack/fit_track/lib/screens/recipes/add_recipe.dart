import 'package:fit_track/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../../providers/recipe_provider.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final _formKey = GlobalKey<FormState>();
  final _recipeNameController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _cookTimeController = TextEditingController();
  final _portionsController = TextEditingController();
  final _kcalController = TextEditingController();
  final _carbsController = TextEditingController();
  final _sugarsController = TextEditingController();
  final _fatController = TextEditingController();
  final _proteinController = TextEditingController();

  String error = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _recipeNameController.dispose();
    _instructionsController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    _portionsController.dispose();
    _kcalController.dispose();
    _carbsController.dispose();
    _sugarsController.dispose();
    _fatController.dispose();
    _proteinController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.grey[250],
        filled: true);

    return Scaffold(
      appBar: CustomAppBar(title: 'Add recipe', backButton: true),
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 30),

          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Recipe name textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                      controller: _recipeNameController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'The recipe name must be at least 4 characters long';
                        }
                        return null;
                      },
                      decoration:
                          inputDecoration.copyWith(hintText: 'Recipe name'),
                      maxLength: 32),
                ),
                SizedBox(height: 10),

                // Kcal textfield
                Column(
                  children: [
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: _kcalController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the kcal value per serving';
                        } else {
                          if (double.parse(value) > 10000) {
                            return 'The kcal value can\'t be bigger than 10000';
                          }
                        }
                        return null;
                      },
                      decoration:
                          inputDecoration.copyWith(hintText: 'Kcal per serving'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                      ],
                    ),
                  ),
                  ]
                ),
                SizedBox(height: 10),

                // Carbs textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: _carbsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the carbohydrates value (g) per serving';
                      } else {
                        if (double.parse(value) > 1000) {
                          return 'The carbs value can\'t be bigger than 1000';
                        }
                      }
                      return null;
                    },
                    decoration:
                        inputDecoration.copyWith(hintText: 'Carbohydrates (g) per serving'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // Sugars textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: _sugarsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the sugar value (g) per serving';
                      } else {
                        if (double.parse(value) > 1000) {
                          return 'The sugars value can\'t be bigger than 1000';
                        }
                      }
                      return null;
                    },
                    decoration:
                        inputDecoration.copyWith(hintText: 'Sugar (g) per serving'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // Fat textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: _fatController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the fats value (g) per serving';
                      } else {
                        if (double.parse(value) > 1000) {
                          return 'The fats value can\'t be bigger than 1000';
                        }
                      }
                      return null;
                    },
                    decoration:
                        inputDecoration.copyWith(hintText: 'Fats (g) per serving'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // Protein textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: _proteinController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the protein value (g) per serving';
                      } else {
                        if (double.parse(value) > 1000) {
                          return 'The protein value can\'t be bigger than 1000';
                        }
                      }
                      return null;
                    },
                    decoration:
                        inputDecoration.copyWith(hintText: 'Protein (g) per serving'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Add recipe button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: GestureDetector(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  dynamic result =
                      context.read<RecipeProvider>().addDummyRecipe();
                }
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Save recipe',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ))),
    );
  }
}
