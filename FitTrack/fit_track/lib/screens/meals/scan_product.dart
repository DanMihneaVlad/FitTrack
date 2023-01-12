import 'package:fit_track/providers/meals_provider.dart';
import 'package:fit_track/widgets/custom_appbar.dart';
import 'package:fit_track/widgets/custom_food_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:openfoodfacts/model/parameter/SearchTerms.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/LanguageHelper.dart';
import 'package:openfoodfacts/utils/ProductQueryConfigurations.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_alert_dialog.dart';

class ScanProduct extends StatefulWidget {
  const ScanProduct({super.key, required this.mealId});

  final String mealId;

  @override
  State<ScanProduct> createState() => _ScanProductState();
}

class _ScanProductState extends State<ScanProduct> {
  String? scanResult;
  final _quantityController = TextEditingController();

  late Product foundProduct;
  String error = '';
  String saveError = '';
  late Widget foodCard = Container();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Scan product', backButton: true),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () async {
                    await scanBarCode();

                    scanResult = '5449000131805';

                    if (scanResult != '-1') {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(child: CircularProgressIndicator());
                        },
                      );

                      //String barcode = '5449000131805';
                      final conf = ProductQueryConfiguration(scanResult!,
                          version: ProductQueryVersion.v3);
                      final product =
                          await OpenFoodAPIClient.getProductV3(conf);
                      Navigator.of(context).pop();

                      if (product.product != null) {
                        setState(() {
                          foundProduct = product.product!;
                          foodCard = FoodCard(food: foundProduct);
                        });
                      } else {
                        error = 'Could not find the product';
                      }
                    } else {
                      setState(() {
                        error = 'Could not scan the barcode';
                      });
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
                        'Scan barcode',
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
                    } else if (int.parse(_quantityController.text.trim()) <
                        10) {
                      setState(() {
                        saveError = 'Quantity cannot be smaller than 10 grams';
                      });
                    } else if (int.parse(_quantityController.text.trim()) >
                        1000) {
                      setState(() {
                        saveError = 'Quantity cannot be bigger than 1000 grams';
                      });
                    } else {
                      dynamic result = context
                          .read<MealsProvider>()
                          .addFoodProduct(
                              widget.mealId,
                              int.parse(_quantityController.text.trim()),
                              foundProduct);
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

  Future scanBarCode() async {
    String scanResult;

    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#0000FF', "Cancel", true, ScanMode.BARCODE);
    } on Exception catch (e) {
      scanResult = 'Failed to scan';
    }
    if (!mounted) return;

    setState(() {
      this.scanResult = scanResult;
    });
  }

  void clearControllers() {
    _quantityController.clear();
    foodCard = Container();
  }
}
