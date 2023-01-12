import 'package:fit_track/providers/meals_provider.dart';
import 'package:fit_track/widgets/custom_appbar.dart';
import 'package:fit_track/widgets/custom_food_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:openfoodfacts/model/parameter/SearchTerms.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/LanguageHelper.dart';
import 'package:openfoodfacts/utils/ProductQueryConfigurations.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_alert_dialog.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key, required this.mealId});

  final String mealId;

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final _searchContoller = TextEditingController();
  final _quantityController = TextEditingController();

  late Product foundProduct;
  String error = '';
  String saveError = '';
  late Widget foodCard = Container();

  @override
  void dispose() {
    _searchContoller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Search product', backButton: true),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Search textfield
                TextField(
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
                      hintText: 'Search for a product',
                      fillColor: Colors.grey[250],
                      filled: true),
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () async {
                    if (_searchContoller.text.trim().isEmpty) {
                      setState(() {
                        error = 'Please enter a search criteria';
                      });
                    } else {
                      setState(() {
                        error = '';
                      });
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(child: CircularProgressIndicator());
                        },
                      );
                      final searchConf = ProductSearchQueryConfiguration(
                          parametersList: <Parameter>[
                            SearchTerms(terms: [_searchContoller.text.trim()])
                          ]);
                      final product = await OpenFoodAPIClient.searchProducts(
                        User(userId: '', password: ''),
                        searchConf,
                      );
                      Navigator.of(context).pop();
                      if (product.products!.isNotEmpty) {
                        setState(() {
                          foundProduct = product.products![0];
                          foodCard = FoodCard(food: foundProduct);
                        });
                      } else {
                        setState(() {
                          error = 'Could not find any product';
                        });
                      }
                      _searchContoller.clear();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Search product',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Search error
                Text(
                  error,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                foodCard,
                const SizedBox(height: 30),

                // Quantity textfield
                TextField(
                  controller: _quantityController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Enter the quantity in grams',
                      fillColor: Colors.grey[250],
                      filled: true),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),

                const SizedBox(height: 10),
                // Search error
                Text(
                  saveError,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                GestureDetector(
                  onTap: () async {
                    setState(() {
                      saveError = '';
                    });
                    if (foodCard is Container) {
                      saveError = 'Please add a product';
                    } else if (_quantityController.text.trim().isEmpty) {
                      setState(() {
                        saveError = 'Please enter the quantity';
                      });
                    } else if (int.parse(_quantityController.text.trim()) < 10) {
                      setState(() {
                        saveError = 'Quantity cannot be smaller than 10 grams';
                      });
                    } else if (int.parse(_quantityController.text.trim()) > 1000) {
                      setState(() {
                        saveError = 'Quantity cannot be bigger than 1000 grams';
                      });
                    } else {
                      dynamic result = context
                          .read<MealsProvider>()
                          .addFoodProduct(widget.mealId, int.parse(_quantityController.text.trim()), foundProduct);
                      if (result is Exception) {
                        setState(() {
                          saveError = 'Error when saving the recipe';
                        });
                      } else {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                const CustomAlertDialog(
                                    title: 'Successfully saved food product'));
                        clearControllers();
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Add product',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void clearControllers() {
    _searchContoller.clear();
    _quantityController.clear();
    foodCard = Container();
  }
}
