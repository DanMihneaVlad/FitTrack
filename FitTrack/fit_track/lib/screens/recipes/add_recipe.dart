import 'dart:io';

import 'package:fit_track/widgets/custom_alert_dialog.dart';
import 'package:fit_track/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../providers/recipe_provider.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
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
  final _ingredientController = TextEditingController();
  List<String> _ingredients = [];

  String error = '';
  String saveError = '';

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
    _ingredientController.dispose();

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
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 30),

            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Recipe image
                  Stack(children: [
                    CircleAvatar(
                      radius: 80.0,
                      backgroundImage: _image == null
                          ? AssetImage('assets/img/food_default.png')
                          : FileImage(File(_image!.path)) as ImageProvider,
                    ),
                    Positioned(
                        bottom: 10.0,
                        right: 10.0,
                        child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => CustomBottomSheet()));
                            },
                            child: Icon(Icons.camera_alt)))
                  ]),

                  const SizedBox(height: 10),

                  // Recipe name textfield
                  TextFormField(
                    controller: _recipeNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 4) {
                        return 'The recipe name must be at least 4 characters long';
                      }
                      return null;
                    },
                    decoration:
                        inputDecoration.copyWith(hintText: 'Recipe name'),
                    maxLength: 64,
                    minLines: 1,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),

                  // Recipe instructions textfield
                  TextFormField(
                      controller: _instructionsController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 50) {
                          return 'The recipe instructions are too short';
                        }
                        return null;
                      },
                      decoration: inputDecoration.copyWith(
                          hintText: 'Recipe instructions'),
                      maxLength: 2000),
                  const SizedBox(height: 10),

                  // Recipe prep time textfield
                  TextFormField(
                    controller: _prepTimeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the preparation time in minutes';
                      } else {
                        if (int.parse(value) > 600) {
                          return 'The prep time can\'t be bigger than 600 minutes';
                        }
                      }
                      return null;
                    },
                    decoration: inputDecoration.copyWith(
                        hintText: 'Preparation time in minutes'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Recipe cook time textfield
                  TextFormField(
                    controller: _cookTimeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the cooking time in minutes';
                      } else {
                        if (int.parse(value) > 1000) {
                          return 'The cooking time can\'t be bigger than 1000 minutes';
                        }
                      }
                      return null;
                    },
                    decoration: inputDecoration.copyWith(
                        hintText: 'Cooking time in minutes'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Portions textfield
                  TextFormField(
                    controller: _portionsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of portions';
                      } else {
                        if (int.parse(value) > 1000) {
                          return 'The number of portions can\'t be bigger than 1000';
                        }
                      }
                      return null;
                    },
                    decoration: inputDecoration.copyWith(
                        hintText: 'Number of portions'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Kcal textfield
                  TextFormField(
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
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Carbs textfield
                  TextFormField(
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
                    decoration: inputDecoration.copyWith(
                        hintText: 'Carbohydrates (g) per serving'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Sugars textfield
                  TextFormField(
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
                    decoration: inputDecoration.copyWith(
                        hintText: 'Sugar (g) per serving'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Fat textfield
                  TextFormField(
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
                    decoration: inputDecoration.copyWith(
                        hintText: 'Fats (g) per serving'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Protein textfield
                  TextFormField(
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
                    decoration: inputDecoration.copyWith(
                        hintText: 'Protein (g) per serving'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            // Ingredient textfield
            TextField(
              controller: _ingredientController,
              decoration: inputDecoration.copyWith(
                  hintText:
                      'Please add the ingredient and quantity, and save it by pressing the button'),
              maxLength: 64,
              minLines: 2,
              maxLines: 3,
            ),
            const SizedBox(height: 10),

            // Add ingredient button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: GestureDetector(
                onTap: () async {
                  if (_ingredientController.text.trim().length >= 4) {
                    setState(() {
                      error = '';
                      _ingredients.add(_ingredientController.text.trim());
                      _ingredientController.clear();
                    });
                  } else {
                    setState(() {
                      error = 'Ingredient must be at least 4 characters long';
                    });
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
                      'Add ingredient',
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
            const SizedBox(height: 10),

            Text(
              error,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Ingredient list
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Ingredient list',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _ingredients.map((str) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '\u2022',
                      style: TextStyle(fontSize: 12, height: 1.5),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(str, style: TextStyle(fontSize: 14)),
                    )
                  ],
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            // Add recipe button
            GestureDetector(
              onTap: () async {
                setState(() {
                  saveError = '';
                });
                if (_formKey.currentState!.validate()) {
                  if (_ingredients.isEmpty) {
                    setState(() {
                      error = 'Ingredient list cannot be empty';
                    });
                  } else {
                    if (_image == null) {
                      setState(() {
                        saveError = 'Please add an image for the recipe';
                      });
                    } else {
                      dynamic result = context
                          .read<RecipeProvider>()
                          .addRecipe(
                              _recipeNameController.text.trim(),
                              _image,
                              _ingredients,
                              _instructionsController.text.trim(),
                              _prepTimeController.text.trim(),
                              _cookTimeController.text.trim(),
                              _portionsController.text.trim(),
                              _kcalController.text.trim(),
                              _carbsController.text.trim(),
                              _sugarsController.text.trim(),
                              _fatController.text.trim(),
                              _proteinController.text.trim());
                      if (result is Exception) {
                        setState(() {
                          saveError = 'Error when saving the recipe';
                        });
                      } else {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                const CustomAlertDialog(
                                    title: 'Successfully added recipe'));
                        clearControllers();
                      }
                    }
                  }
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
            const SizedBox(height: 10),

            // Save error
            Text(
              saveError,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30)
          ]),
        ),
      ))),
    );
  }

  void clearControllers() {
    _recipeNameController.clear();
    _instructionsController.clear();
    _prepTimeController.clear();
    _cookTimeController.clear();
    _portionsController.clear();
    _kcalController.clear();
    _carbsController.clear();
    _sugarsController.clear();
    _fatController.clear();
    _proteinController.clear();
    _ingredientController.clear();
    _ingredients = [];
    _image = null;
  }

  Widget CustomBottomSheet() {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [
        Text(
          'Choose recipe picture',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              label: Text('Camera'),
              icon: Icon(Icons.camera),
              onPressed: (() {
                takePhoto(ImageSource.camera);
              }),
            ),
            TextButton.icon(
              label: Text('Gallery'),
              icon: Icon(Icons.image),
              onPressed: (() {
                takePhoto(ImageSource.gallery);
              }),
            ),
          ],
        )
      ]),
    );
  }

  void takePhoto(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    setState(() {
      _image = pickedFile;
    });
  }
}
