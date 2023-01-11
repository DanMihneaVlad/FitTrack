import 'package:fit_track/screens/home/home_widget.dart';
import 'package:fit_track/widgets/custom_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../providers/diet_plan_provider.dart';
import '../../providers/meals_provider.dart';
import '../../widgets/custom_create_diet_plan_widgets.dart';

const List<String> mealTypes = <String>[
  'Breakfast',
  'Snack',
  'Lunch',
  'Dinner'
];

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  final _mealDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var dietPlanProvider = context.watch<DietPlanProvider>();
    var mealsProvider = context.watch<MealsProvider>();
    var widgets = CustomCreateDietPlanWidgets().createWidgets(
        'It appears you don\'t have a diet plan yet. Before you start adding meals please go to the home page and create one.');

    return FutureBuilder(
        future: Future.wait([
          dietPlanProvider.getDietPlan,
          mealsProvider.getTodayDaySummary,
        ]),
        builder: (BuildContext ctx, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            if (asyncSnapshot.hasError) {
              return const Center(
                  child: Text('Could not load the meals data!'));
            } else {
              return Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          height: 230,
                          width: 400,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 194, 194, 194),
                                  spreadRadius: 1.5,
                                  blurRadius: 5,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: dietPlanProvider.dietPlan.uid.isEmpty
                                    ? [
                                        widgets[0],
                                        widgets[1],
                                        widgets[2],
                                      ]
                                    : [
                                        Text(mealsProvider.todayDaySummary.uid !=
                                                ''
                                            ? 'You have a day summary'
                                            : 'No day summary found'),
                                      ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: dietPlanProvider.dietPlan.uid.isNotEmpty
                    ? FloatingActionButton(
                        child: Icon(Icons.add, size: 35),
                        onPressed: () => {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Create a meal'),
                              content: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter a description',
                                ),
                                maxLength: 16,
                                controller: _mealDescriptionController,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: (() async {
                                      dynamic result =
                                          await mealsProvider.addMeal(_mealDescriptionController.text.trim());
                                      
                                      _mealDescriptionController.clear();
                                      Navigator.of(context).pop();
                                    }),
                                    child: Text('Submit'))
                              ],
                            ),
                          )
                        },
                      )
                    : Container(),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
